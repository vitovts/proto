

- Аналог
- Типы сигнализации
  1. Линейная (supervisory)
     - on-hook
     - off-hook
     - ringing - установлено соединение со АТС
  2. Регистровая (address)
     - pulse (импульсная)
     - dtmf (тоновый)
  3. Информациолнная (informational)
     - зумер
     - отбой
     - КПВ (занято)



Type connecting

ATC-1   <<-->> ATC-2

        --->>> Sieze (Setup) --- number in-out (repit to time)
        ---<<< Sieze (Setup) Acknowledge
        ---<<< Dial Tone (optional)
        --->>> Dialing
        ---<<< Ring Back Tone (Alert)
        ---<<< Connect
        <<-->> Conversation (Voce)
        ---<<< Disconect
        ---<<< Busy Tone
        --->>> Disconnect
    
    
Протоколы передачи медиа
  - RTP (Real-Time Transport Protocol) - передача аудио и видео потоков по IP сетя
  - RTCP (Real-Time Transport Protocol)
  - cRTP
  - SRTP
