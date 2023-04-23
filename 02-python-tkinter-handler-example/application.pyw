import tkinter
import tkinter.ttk
import threading
import time 


class Application(tkinter.Tk):
    def __init__(self):
        super().__init__()
        self.withdraw()
        self.files = ['first', 'second', 'third', 'fourth']
        self.handle_files()

    def handle_files(self):
        # если файл есть - рисуем шкалу прогресса и запускаем поток на обработку файла
        if len(self.files) > 0:
            file = self.files.pop(0)
            # отрисовка шкалы
            panel = self.draw_progressbar_panel(file)
            # запуск обработки файла
            thread = threading.Thread(target=self.data_loading, args=(file,))
            thread.start()
            # запуск "ждуна", которой проконтролирует окончание загрузки файла
            self.handle_data_loading_ending(thread, panel)
            
        # если обработка файлов закончена - уничтожаем наше приложение
        else:
            self.destroy()
    
    def handle_data_loading_ending(self, thread, panel):
        # каждые 100 миллисекунд проверяем, закончилась ли обработка файла
        if thread.is_alive():
            self.after(100, lambda: self.handle_data_loading_ending(thread, panel))
            
        # если обработка окончена - уничтожаем панель со шкалой и пытаемся обработать следующий файл
        else:    
            panel.destroy()
            self.handle_files()
            
    def data_loading(self, file):
        print('Начинаем обработку файла {} ...'.format(file))
        # эмуляция обработки большого файла - спим 3 секунды
        time.sleep(3)
        print('Заканчиваем обработку файла {} ...'.format(file))
            
    def draw_progressbar_panel(self, file):
        # определяем позицию окна (центр экрана)
        screen_width = self.winfo_screenwidth()
        screen_height = self.winfo_screenheight()
        width = 300
        height = 120
        x = int((screen_width/2) - (width/2))
        y = int((screen_height/2) - (height/2))
        geometry = '{}x{}+{}+{}'.format(width, height, x, y)
        
        # рисуем новое окно
        panel = tkinter.Toplevel(self)
        panel.geometry(geometry)
        panel.title('File "{}"'.format(file))
        panel.grid()
        
        # рисуем шкалу прогресса
        bar = tkinter.ttk.Progressbar(
            panel,
            orient='horizontal',
            mode='indeterminate',
            length=280
        )
        bar.grid(column=0, row=0, columnspan=2, padx=10, pady=20)
        bar.start()
        panel.focus_force()
        
        return panel


if __name__ == '__main__':
    Application().mainloop()
