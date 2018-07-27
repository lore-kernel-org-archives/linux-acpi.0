From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] ACPI fix for v4.18-rc7
Date: Fri, 27 Jul 2018 11:37:51 -0700
Message-ID: <CA+55aFx0SEn1AUspujpr-TDGgJkphrRJz_oL_R+XVxUUWV4pkg@mail.gmail.com>
References: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

My XPS13 laptop is unhappy with something recent.

As of yesterday, I get this at bootup:

  ACPI: Added _OSI(Module Device)
  ACPI: Added _OSI(Processor Device)
  ACPI: Added _OSI(3.0 _SCP Extensions)
  ACPI: Added _OSI(Processor Aggregator Device)
  ACPI: Added _OSI(Linux-Dell-Video)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI: 9 ACPI AML tables successfully acquired and loaded

It does *not* happen in

    Linux version 4.18.0-rc6-00110-g6e77b267723c

but it *does* happen in

    Linux version 4.18.0-rc6-00152-gcd3f77d74ac3

and while I didn't bisect it, I'm assuming it's due to 73c2a01c52b6
("ACPICA: AML Parser: ignore dispatcher error status during table
load")

Ideas?

Note only the errors are new. On older kernels, I just get:

  ACPI: Added _OSI(Module Device)
  ACPI: Added _OSI(Processor Device)
  ACPI: Added _OSI(3.0 _SCP Extensions)
  ACPI: Added _OSI(Processor Aggregator Device)
  ACPI: Added _OSI(Linux-Dell-Video)
  ACPI: 9 ACPI AML tables successfully acquired and loaded

without the big slew of errors.

          Linus
