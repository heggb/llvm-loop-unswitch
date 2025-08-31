#ifndef CONFIG_H
#define CONFIG_H 

// Параметры прохода
struct 
Config 
{
    unsigned Threshold = 80;    // Порог стоимости дублирования
    unsigned MaxVersions = 1;   // Максимальное число созданных версий за проход
    bool WcetMode = true;       // Применять IPP/WCET приоритезацию, если есть профили
    bool NonTrivial = true;     // Разрешить non-trivial unswitch
};

#endif