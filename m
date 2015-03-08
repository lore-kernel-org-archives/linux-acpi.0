From: Rasmus <kernel-bugzilla@pank.eu>
Subject: PROBLEM: Reboots on graphical load w/Intel HD4000 since Linux 3.10
Date: Sun, 08 Mar 2015 18:35:29 +0100
Message-ID: <87oao3bdem.fsf@pank.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Summary of Problem:

    System reboots on graphical load with Intel HD 4000 iGPU since Linux
    3.10

The full bug-report including all attachments is available on bugzilla and
below:

    https://bugzilla.kernel.org/show_bug.cgi?id=3D94551

I hope I have managed to fill the report correctly and provided enough
information.  My apology for the mistakes that remains.  Please let me
know about further information that would be helpful.

Should I try to git bisec Linux between 3.9 and 3.10?  (I'm not sure how
to do this properly, so pointers would be good).

I'm not subscribed to any Linux ML.  If possible, please keep me in Cc if
replying to the email.

Thanks,
Rasmus


1 Full description of the problem/report
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90

  I experience reboots crashing on my Thinkpad W530 with HD4000 whenever
  the iGPU is exposed to moderate load, e.g. playing a video game or
  movies.  This only happens when I employ the Intel iGPU.  It happens
  irrespective of whether Nvidia Optimus in enabled.

  It seems this error was introduced between Linux 3.9 and 3.10.  Fedora
  19 is stable.  Fedora 20 is not.  I have tested 3.9 with the current
  Xorg stack on Archlinux and it is also stable.  3.10 is not.  Windows
  7 is also stable.

  It=E2=80=99s not a hardware issue!  I can run mprime cpu load indefinitel=
y on
  the system without a crash.  The temperature never goes above 90
  degrees when I run any test.  This problem is confirmed on two W530
  machines.

  It does not seem to be a Intel driver bug as I the current Xorg stack
  works with Linux 3.9.  A bug was first filled against Intel drivers,
  see section [#links].

  Logs are produced with clean Fedora images.


  [#links] See section 7.2


2 Keywords
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90

  hard crash, Kernel, Thinkpad, Intel graphics, iGPU


3 Kernel version (from /proc/version)
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90

3.1 Fedora 21
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  Linux version 3.18.7-200.fc21.x86_64
  (mockbuild@bkernel02.phx2.fedoraproject.org) (gcc version 4.9.2
  20141101 (Red Hat 4.9.2-1) (GCC) ) #1 SMP Wed Feb 11 21:53:17 UTC 2015


3.2 Fedora 19
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  Linux version 3.9.5-301.fc19.x86_64
  (mockbuild@bkernel01.phx2.fedoraproject.org) (gcc version 4.8.1
  20130603 (Red Hat 4.8.1-1) (GCC) ) #1 SMP Tue Jun 11 19:39:38 UTC 2013


4 Output of Oops.. message (if applicable) with symbolic information
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90

  I don=E2=80=99t see Oops messages=E2=80=A6  Please see the enclosed files.


5 How to reproduce
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90

  1. Download gputest from [http://www.geeks3d.com/gputest/]
  2. Run start_furmark_windowed_1024x640.sh.  Put it in full screen if
     you like.
  3. On my system the computer crashes and reboots typically within 10
     minutes.
     The reboot is as if power was cut and returned.  Like if the CPU
     was
     overheating (which it is not).  IOW: The systemctl shutdown logs
     are not
     displayed.


6 Environment
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90

  Thinkpad W530?  (I don=E2=80=99t understand this question).


6.1 Software (add the output of the ver_linux script here)
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80

6.1.1 Fedora 21
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  Please see ver_linux_fedora_21.txt.


6.1.2 Fedora 19
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  Please see ver_linux_fedora_19.txt.


6.2 Processor information (from /proc/cpuinfo)
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80

6.2.1 Fedora 21
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  I believe this is part of ver_linux_fedora_21.txt.


6.2.2 Fedora 19
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  I believe this is part of ver_linux_fedora_19.txt.


6.3 Module information (from /proc/modules)
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80

6.3.1 Fedora 21
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  Please see modules_fedora_21.txt


6.3.2 Fedora 19
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  Please see modules_fedora_19.txt


6.4 Loaded driver and hardware information (/proc/ioports, /proc/iomem)
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80

6.4.1 Fedora 21
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

6.4.1.1 /proc/ioports
=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=
=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=
=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84

  Please see ioports_fedora_21.txt.


6.4.1.2 /proc/iomem
=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=
=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=
=84=E2=94=84=E2=94=84

  Please see iomem_fedora_21.txt.


6.4.2 Fedora 19
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

6.4.2.1 /proc/ioports
=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=
=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=
=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84

  Please see ioports_fedora_19.txt.


6.4.2.2 /proc/iomem
=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=
=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=84=E2=94=
=84=E2=94=84=E2=94=84

  Please see iomem_fedora_19.txt.


6.5 PCI information (=E2=80=98lspci -vvv=E2=80=99 as root)
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80

6.5.1 Fedora 21
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  Please see lspci_fedora_21.txt


6.5.2 Fedora 19
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  Please see lspci_fedora_19.txt


6.6 SCSI information (from /proc/scsi/scsi)
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80

6.6.1 Fedora 21
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  Attached devices:
  Host: scsi0 Channel: 00 Id: 00 Lun: 00
    Vendor: ATA Model: Crucial_CT256MX1 Rev: MU01
    Type: Direct-Access ANSI SCSI revision: 05
  Host: scsi1 Channel: 00 Id: 00 Lun: 00
    Vendor: MATSHITA Model: DVD-RAM UJ8C0 Rev: SB01
    Type: CD-ROM ANSI SCSI revision: 05


6.6.2 Fedora 19
=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=
=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C=E2=95=8C

  Attached devices:
  Host: scsi0 Channel: 00 Id: 00 Lun: 00
    Vendor: ATA Model: Crucial_CT256MX1 Rev: MU01
    Type: Direct-Access ANSI SCSI revision: 05
  Host: scsi1 Channel: 00 Id: 00 Lun: 00
    Vendor: MATSHITA Model: DVD-RAM UJ8C0 Rev: SB01
    Type: CD-ROM ANSI SCSI revision: 05
  Host: scsi6 Channel: 00 Id: 00 Lun: 00
    Vendor: Kingston Model: DataTraveler 3.0 Rev: PMAP
    Type: Direct-Access ANSI SCSI revision: 06


6.7 Other information that might be relevant to the problem
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80

  Not that I am aware of.


7 Other notes, patches, fixes, workarounds
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90

7.1 Other enclosures
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80

  dmesg_fedora_21.txt: netconsole output of Fedora 21 with crash.
  dmesg_fedora_19.txt: dmesg after running Furmark for a bit in
                       Fedora 19.  (My understanding is that this should
                       be similar to
                       the netcat output)
  xorg_crash_fedora_21.txt: an example of an Xorg-log when the server
                            is crashing.
  bios_settings.txt: settings in the bios with some notes.


7.2 Other iteration of this bug report
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80

  This bug was first reported here:
  [https://bugs.freedesktop.org/show_bug.cgi?id=3D89451]

  It has been discussed here:
  [http://forum.thinkpads.com/viewtopic.php?f=3D70&t=3D116472]


--=20
Got mashed potatoes. Ain't got no T-Bone. No T-Bone

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=bios_settings.txt
Content-Transfer-Encoding: base64

UmFzbXVzIFBhbmsgUm91bHVuZA0KDQoNCjEgTWFpbg0K4pWQ4pWQ4pWQ4pWQ4pWQ4pWQDQoNCiAg
4oCiIFVFRkkgQklPUyB2ZXJzaW9uOiBHNUVUQTFXVyAoMi42MSkNCiAg4oCiIFVFRkkgQklPUyBE
YXRlOiAyMDE1LTAxLTIyDQogIOKAoiBFbWJlZGRlZCBDb250cm9sbGVyIFZlcnNpb246IEc0SFQz
OVdXICgxLjEzKQ0KICDigKIgTWFjaGluZSBUeXBlIE1vZGVsOiAyNTUxNTBHDQogIOKAoiBTeXN0
ZW0tdW5pdCBTZXJpYWwgbnVtYmVyOiB4DQogIOKAoiBTeXN0ZW0gYm9hcmQgc2VyaWFsIG51bWJl
cjogeA0KICDigKIgQXNzZXQgdGFnOiBubyBhc3NldCBpbmZvcm1hdGlvbg0KICDigKIgQ1BVIHR5
cGU6IEludGVsIENvcmUgaTctMzg0MFFNDQogIOKAoiBDUFUgc3BlZWQ6IDIuOEdoeg0KICDigKIg
TWVtb3J5OiAzMkdCDQogIOKAoiBVVUlEOiB4DQogIOKAoiBNYWMgYWRkcmVzczogeA0KICDigKIg
cHJlaW5zdGFsbGVkIE9TIGxpY2Vuc2U6IE5vIERQSw0KICDigKIgVUVGSSBzZWN1cmUgYm9vdDog
b2ZmDQoNCg0KMiBjb25maWcNCuKVkOKVkOKVkOKVkOKVkOKVkOKVkOKVkA0KDQoyLjEgbmV0d29y
aw0K4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSADQoNCiAg4oCiIFdha2Ugb24gTEFO
OiBhYyBvbmx5DQogIOKAoiBVRUZJIGlwdjQgbmV0d29yayBzdGFjazogMQ0KICDigKIgVUVGSSBp
cHY0IG5ldHdvcmsgc3RhY2s6IDENCiAg4oCiIFVFRkkgcHhlIGJvb3QgcHJpb3JpdHk6IGlwdjQN
Cg0KDQoyLjIgdXNiDQrilIDilIDilIDilIDilIDilIDilIANCg0KICDigKIgdXNiIHVlZmkgYmlv
cyBzdXBwb3J0OiAxDQogIOKAoiBhbHdheXMgb24gdXNiOiAxDQogIOKAoiBhbHdheXMgb24gdXNi
IGNoYXJnZSBpbiBvZmYgbW9kZTogMA0KICDigKIgdXNiIDMgbW9kZTogYXV0bw0KDQoNCjIuMyBr
ZXlib2FyZC9tb3VzZQ0K4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSADQoNCiAg4oCiIHRyYWNrcG9pbnQ6IDENCiAg4oCiIHRvdWNoIHBhZDogMQ0K
ICDigKIgZm4tY3RybCBzd2FwOiAwDQogIOKAoiBmbiBrZXkgbG9jazogMA0KICDigKIga2V5Ym9h
cmQgaWxsdW1pbmF0aW9uOiBib3RoDQoNCg0KMi40IGRpc3BsYXkNCuKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgA0KDQogIOKAoiBib290IGRpc3BsYXkgZGV2aWNlOiBUaGlua3BhZCBs
Y2QNCiAg4oCiIGdyYXBoaWNzIGRldmljZTogSW50ZWdyYXRlZCAoY2hvaWNlczogaW50ZWdyYXRl
ZCwgZGlzY3JldGUsIE52aWRpYQ0KICAgIG9wdGltdXMpDQogIOKAoiBPUyBkZXRlY3Rpb24gb2Yg
bnZpZGlhIG9wdGltdXM6IDANCg0KDQoyLjUgcG93ZXINCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgA0KDQogIOKAoiBJbnRlbCBzcGVlZHN0ZXA6IDENCiAgICDigKIgbW9kZSBmb3IgYWM6IG1h
eCBwZXJmb3JtYW5jZQ0KICAgIOKAoiBtb2RlIGZvciBiYXR0ZXJ5OiBiYXR0ZXJ5IG9wdGltaXph
dGlvbg0KICDigKIgYWRhcHRpdmUgdGhlcm1hbCBtYW5hZ2VtZW50Og0KICAgIOKAoiBzY2hlbWUg
Zm9yIGFjOiBtYXggcGVyZm9ybWFuY2UNCiAgICDigKIgc2NoZW1lIGZvciBiYXQ6IGJhbGFuY2Vk
DQogIOKAoiBvcHRpY2FsIGRyaXZlIHNwZWVkOiBub3JtYWwNCiAg4oCiIHBjaSBleHByZXNzIHBv
d2VyIG1hbmFnZW1lbnQ6IDAgKHByb2JsZW0gYWxzbyBoYXBwZW5zIHdoZW4gMSkNCiAg4oCiIGV4
cHJlc3MgY2FyZCBzcGVlZDogYXV0bw0KICDigKIgcG93ZXIgb24gd2l0aCBhYyBhdHRhY2g6IDAN
CiAg4oCiIGludGVsIHJhcGlkIHN0YXJ0IHRlY2g6IDAgKHByb2JsZW0gYWxzbyBoYXBwZW5zIHdo
ZW4gMSkNCg0KDQoyLjYgYmVlcCBhbmQgYWxhcm0NCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0KDQogIOKAoiBwYXNzd29yZCBiZWVwOiAwDQog
IOKAoiBrZXlib2FyZCBiZWVwOiAxDQoNCg0KMi43IHNhdGENCuKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgA0KDQogIOKAoiBTYXRhIG1vZGU6IEFIQ0kNCg0KDQoyLjggY3B1DQrilIDilIDilIDilIDi
lIDilIDilIANCg0KICDigKIgY29yZSBtdWx0aSBwcm9jZXNzaW5nOiAxDQogIOKAoiBpbnRlbCBo
eXBlciB0aHJlYWRpbmcgdGVjaDogMQ0KDQoNCjIuOSBpbnRlbCBhbXQNCuKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0KDQogIOKAoiBpbnRlbCBhbXQgY29udHJvbDogMA0K
DQoNCjMgZGF0ZS90aW1lDQrilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZANCg0KICBk
ZWZhdWx0DQoNCg0KNCBzZWN1cml0eQ0K4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQ4pWQDQoN
CjQuMSBwYXNzd29yZCAoc2tpcHBlZCkNCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0KDQoNCjQuMiBmaW5nZXJwcmludCAo
c2tpcHBlZCkNCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0KDQoNCjQuMyB1ZWZpIGJpb3MgdXBkYXRlIG9w
dGlvbg0K4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSADQoNCiAg4oCiIGZsYXNoIHVwZGF0ZSBieSBl
bmQgdXNlcjogMQ0KICDigKIgc2VjdXJlIHJvbGxiYWNrIHByZXZlbnRpb246IDANCg0KDQo0LjQg
bWVtb3J5IHByb3RlY3Rpb24NCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgA0KDQogIGV4ZWN1dGlvbiBwcmV2ZW50aW9uOiAwIChw
cm9ibGVtIGFsc28gaGFwcGVucyB3aGVuIDEpDQoNCg0KNC41IHZpcnR1YWxpemF0aW9uDQrilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIANCg0KICDi
gKIgaW50ZWwgdmlydC4gdGVjaDogMQ0KICDigKIgaW50ZWwgdnQtZCBmZWF0dXJlOiAxDQoNCg0K
NC42IEkvTyBwb3J0cyAoYWxsIGVuYWJsZWQpDQrilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIANCg0K
DQo0LjcgYW50aS10aGVmdCAoZGlzYWJsZWQpDQrilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIANCg0KDQo0Ljgg
c2VjdXJlLWJvb3QNCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gA0KDQogIOKAoiBzZWN1cmUgYm90OiBkaXNhYmxlZA0KICDigKIgcGxhdGZvcm0gbW9kZTogdXNl
ciBtb2RlDQogIOKAoiBzZWN1cmUgYm9vdCBtb2RlOiBzdGQuIG1vZGUNCg0KDQo1IFN0YXJ0dXAg
KGRlZmF1bHQpDQrilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDilZDi
lZDilZDilZDilZANCg==
--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=dmesg_fedora_19.txt

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.9.5-301.fc19.x86_64 (mockbuild@bkernel01.phx2.fedoraproject.org) (gcc version 4.8.1 20130603 (Red Hat 4.8.1-1) (GCC) ) #1 SMP Tue Jun 11 19:39:38 UTC 2013
[    0.000000] Command line: initrd=initrd0.img root=live:CDLABEL=Fedora-Live-Desktop-x86_64-19-1 rootfstype=auto ro rd.live.image quiet  rhgb rd.luks=0 rd.md=0 rd.dm=0  BOOT_IMAGE=vmlinuz0 
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x0000000040003fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040004000-0x0000000040004fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000040005000-0x00000000a59f3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000a59f4000-0x00000000bae9efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bae9f000-0x00000000baf9efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000baf9f000-0x00000000baffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bafff000-0x00000000bf9fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083e5fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000083e600000-0x000000083effffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: LENOVO 244150G/244150G, BIOS G5ETA1WW (2.61 ) 01/22/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x83e600 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 0BC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0BB000000 mask FFF000000 uncachable
[    0.000000]   5 base 100000000 mask F00000000 write-back
[    0.000000]   6 base 200000000 mask E00000000 write-back
[    0.000000]   7 base 400000000 mask C00000000 write-back
[    0.000000]   8 base 800000000 mask FC0000000 write-back
[    0.000000]   9 base 83F000000 mask FFF000000 uncachable
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820: last_pfn = 0xa59f4 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f0100-0x000f010f] mapped at [ffff8800000f0100]
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01fc4000, 0x01fc4fff] PGTABLE
[    0.000000] BRK [0x01fc5000, 0x01fc5fff] PGTABLE
[    0.000000] BRK [0x01fc6000, 0x01fc6fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x83e400000-0x83e5fffff]
[    0.000000]  [mem 0x83e400000-0x83e5fffff] page 2M
[    0.000000] BRK [0x01fc7000, 0x01fc7fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x83c000000-0x83e3fffff]
[    0.000000]  [mem 0x83c000000-0x83e3fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x800000000-0x83bffffff]
[    0.000000]  [mem 0x800000000-0x83bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20200000-0x40003fff]
[    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0x40003fff] page 4k
[    0.000000] BRK [0x01fc8000, 0x01fc8fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x40005000-0xa59f3fff]
[    0.000000]  [mem 0x40005000-0x401fffff] page 4k
[    0.000000]  [mem 0x40200000-0xa57fffff] page 2M
[    0.000000]  [mem 0xa5800000-0xa59f3fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x7ffffffff]
[    0.000000]  [mem 0x100000000-0x7ffffffff] page 2M
[    0.000000] RAMDISK: [mem 0x1e31e000-0x1ffdefff]
[    0.000000] ACPI: RSDP 00000000000f0120 00024 (v02 LENOVO)
[    0.000000] ACPI: XSDT 00000000baffe170 000C4 (v01 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: FACP 00000000bafe6000 0010C (v05 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: DSDT 00000000bafe8000 10FD9 (v01 LENOVO TP-G5    00002610 INTL 20061109)
[    0.000000] ACPI: FACS 00000000baf54000 00040
[    0.000000] ACPI: SLIC 00000000baffd000 00176 (v01 LENOVO TP-G5    00002610 PTL  00000001)
[    0.000000] ACPI: TCPA 00000000baffc000 00032 (v02    PTL   LENOVO 06040000 LNVO 00000001)
[    0.000000] ACPI: SSDT 00000000baffb000 00408 (v01 LENOVO TP-SSDT2 00000200 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000baffa000 00033 (v01 LENOVO TP-SSDT1 00000100 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000baff9000 00797 (v01 LENOVO SataAhci 00001000 INTL 20061109)
[    0.000000] ACPI: HPET 00000000bafe4000 00038 (v01 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: APIC 00000000bafe3000 00098 (v01 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: MCFG 00000000bafe2000 0003C (v01 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: ECDT 00000000bafe1000 00052 (v01 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: FPDT 00000000bafe0000 00064 (v01 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: ASF! 00000000bafe7000 000A5 (v32 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: UEFI 00000000bafdf000 0003E (v01 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: UEFI 00000000bafde000 00042 (v01 PTL      COMBUF 00000001 PTL  00000001)
[    0.000000] ACPI: POAT 00000000bafdd000 00055 (v03 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: SSDT 00000000bafdc000 00D23 (v01  PmRef  Cpu0Ist 00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 00000000bafdb000 00A83 (v01  PmRef    CpuPm 00003000 INTL 20061109)
[    0.000000] ACPI: DMAR 00000000bafda000 000B8 (v01 INTEL      SNB  00000001 INTL 00000001)
[    0.000000] ACPI: UEFI 00000000bafd9000 002A6 (v01 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: DBG2 00000000bafd8000 000E9 (v00 LENOVO TP-G5    00002610 PTL  00000002)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000083e5fffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x83e5fffff]
[    0.000000]   NODE_DATA [mem 0x83e5cd000-0x83e5e0fff]
[    0.000000]  [ffffea0000000000-ffffea0020ffffff] PMD -> [ffff88081e200000-ffff88083dbfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x83e5fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009cfff]
[    0.000000]   node   0: [mem 0x00100000-0x1fffffff]
[    0.000000]   node   0: [mem 0x20200000-0x40003fff]
[    0.000000]   node   0: [mem 0x40005000-0xa59f3fff]
[    0.000000]   node   0: [mem 0x100000000-0x83e5fffff]
[    0.000000] On node 0 totalpages: 8273295
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 10528 pages used for memmap
[    0.000000]   DMA32 zone: 673779 pages, LIFO batch:31
[    0.000000]   Normal zone: 118680 pages used for memmap
[    0.000000]   Normal zone: 7595520 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 0000000020000000 - 0000000020200000
[    0.000000] PM: Registered nosave memory: 0000000040004000 - 0000000040005000
[    0.000000] PM: Registered nosave memory: 00000000a59f4000 - 00000000bae9f000
[    0.000000] PM: Registered nosave memory: 00000000bae9f000 - 00000000baf9f000
[    0.000000] PM: Registered nosave memory: 00000000baf9f000 - 00000000bafff000
[    0.000000] PM: Registered nosave memory: 00000000bafff000 - 00000000bfa00000
[    0.000000] PM: Registered nosave memory: 00000000bfa00000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed08000
[    0.000000] PM: Registered nosave memory: 00000000fed08000 - 00000000fed09000
[    0.000000] PM: Registered nosave memory: 00000000fed09000 - 00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffc00000
[    0.000000] PM: Registered nosave memory: 00000000ffc00000 - 0000000100000000
[    0.000000] e820: [mem 0xbfa00000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88083e200000 s85120 r8192 d21376 u262144
[    0.000000] pcpu-alloc: s85120 r8192 d21376 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8144002
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: initrd=initrd0.img root=live:CDLABEL=Fedora-Live-Desktop-x86_64-19-1 rootfstype=auto ro rd.live.image quiet  rhgb rd.luks=0 rd.md=0 rd.dm=0  BOOT_IMAGE=vmlinuz0 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 32462024k/34576384k available (6473k kernel code, 1483204k absent, 631156k reserved, 6764k data, 1352k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=8.
[    0.000000] NR_IRQS:8448 nr_irqs:744 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 132644864 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.001000] tsc: Detected 2793.650 MHz processor
[    0.000010] Calibrating delay loop (skipped), value calculated using timer frequency.. 5587.30 BogoMIPS (lpj=2793650)
[    0.000012] pid_max: default: 32768 minimum: 301
[    0.000037] Security Framework initialized
[    0.000043] SELinux:  Initializing.
[    0.000049] SELinux:  Starting in permissive mode
[    0.001909] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.008992] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.012081] Mount-cache hash table entries: 256
[    0.012230] Initializing cgroup subsys cpuacct
[    0.012232] Initializing cgroup subsys memory
[    0.012238] Initializing cgroup subsys devices
[    0.012239] Initializing cgroup subsys freezer
[    0.012240] Initializing cgroup subsys net_cls
[    0.012241] Initializing cgroup subsys blkio
[    0.012242] Initializing cgroup subsys perf_event
[    0.012265] CPU: Physical Processor ID: 0
[    0.012266] CPU: Processor Core ID: 0
[    0.012270] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.012589] mce: CPU supports 9 MCE banks
[    0.012601] CPU0: Thermal monitoring enabled (TM1)
[    0.012609] Last level iTLB entries: 4KB 512, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
tlb_flushall_shift: 1
[    0.012712] Freeing SMP alternatives: 24k freed
[    0.013689] ACPI: Core revision 20130117
[    0.019055] ACPI: All ACPI Tables successfully acquired
[    0.020312] ftrace: allocating 24409 entries in 96 pages
[    0.030340] dmar: Host address width 36
[    0.030341] dmar: DRHD base: 0x000000fed90000 flags: 0x0
[    0.030346] dmar: IOMMU 0: reg_base_addr fed90000 ver 1:0 cap c0000020e60262 ecap f0101a
[    0.030347] dmar: DRHD base: 0x000000fed91000 flags: 0x1
[    0.030350] dmar: IOMMU 1: reg_base_addr fed91000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.030351] dmar: RMRR base: 0x000000ba3ba000 end: 0x000000ba3d0fff
[    0.030352] dmar: RMRR base: 0x000000bb800000 end: 0x000000bf9fffff
[    0.030425] IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.030426] HPET id 0 under DRHD base 0xfed91000
[    0.030553] Enabled IRQ remapping in x2apic mode
[    0.030554] Enabling x2apic
[    0.030555] Enabled x2apic
[    0.030562] Switched APIC routing to cluster x2apic.
[    0.031006] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.041020] smpboot: CPU0: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz (fam: 06, model: 3a, stepping: 09)
[    0.041029] TSC deadline timer enabled
[    0.041036] Performance Events: PEBS fmt1+, 16-deep LBR, IvyBridge events, Intel PMU driver.
[    0.041041] ... version:                3
[    0.041042] ... bit width:              48
[    0.041042] ... generic registers:      4
[    0.041043] ... value mask:             0000ffffffffffff
[    0.041044] ... max period:             000000007fffffff
[    0.041045] ... fixed-purpose events:   3
[    0.041045] ... event mask:             000000070000000f
[    0.055698] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.042021] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 OK
[    0.136867] Brought up 8 CPUs
[    0.136870] smpboot: Total of 8 processors activated (44698.40 BogoMIPS)
[    0.144575] devtmpfs: initialized
[    0.144738] PM: Registering ACPI NVS region [mem 0xbae9f000-0xbaf9efff] (1048576 bytes)
[    0.145286] atomic64 test passed for x86-64 platform with CX8 and with SSE
[    0.145314] RTC time: 16:45:03, date: 03/08/15
[    0.145355] NET: Registered protocol family 16
[    0.145473] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.145475] ACPI: bus type PCI registered
[    0.145658] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.145660] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.150105] PCI: Using configuration type 1 for base access
[    0.150758] bio: create slab <bio-0> at 0
[    0.150812] ACPI: Added _OSI(Module Device)
[    0.150813] ACPI: Added _OSI(Processor Device)
[    0.150814] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.150815] ACPI: Added _OSI(Processor Aggregator Device)
[    0.152004] ACPI: EC: EC description table is found, configuring boot EC
[    0.155415] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.172094] ACPI: SSDT 00000000bae3a018 00A01 (v01  PmRef  Cpu0Cst 00003001 INTL 20061109)
[    0.172394] ACPI: Dynamic OEM Table Load:
[    0.172395] ACPI: SSDT           (null) 00A01 (v01  PmRef  Cpu0Cst 00003001 INTL 20061109)
[    0.176655] ACPI: SSDT 00000000bae3ba98 00303 (v01  PmRef    ApIst 00003000 INTL 20061109)
[    0.176973] ACPI: Dynamic OEM Table Load:
[    0.176974] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20061109)
[    0.179575] ACPI: SSDT 00000000bae39d98 00119 (v01  PmRef    ApCst 00003000 INTL 20061109)
[    0.179867] ACPI: Dynamic OEM Table Load:
[    0.179868] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20061109)
[    0.184422] ACPI: Interpreter enabled
[    0.184426] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20130117/hwxface-568)
[    0.184430] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20130117/hwxface-568)
[    0.184439] ACPI: (supports S0 S3 S4 S5)
[    0.184440] ACPI: Using IOAPIC for interrupt routing
[    0.184455] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.190336] ACPI: Power Resource [PUBS] (on)
[    0.193694] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[    0.193762] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11)
[    0.193827] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 9 10 11)
[    0.193892] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[    0.193954] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 *7 9 10 11)
[    0.194006] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.194072] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11)
[    0.194136] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11)
[    0.194173] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.194245] PCI host bridge to bus 0000:00
[    0.194248] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.194249] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.194250] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.194252] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.194253] pci_bus 0000:00: root bus resource [mem 0xbfa00000-0xfebfffff]
[    0.194254] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4bfff]
[    0.194261] pci 0000:00:00.0: [8086:0154] type 00 class 0x060000
[    0.194321] pci 0000:00:01.0: [8086:0151] type 01 class 0x060400
[    0.194346] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.194384] pci 0000:00:02.0: [8086:0166] type 00 class 0x030000
[    0.194393] pci 0000:00:02.0: reg 10: [mem 0xf1400000-0xf17fffff 64bit]
[    0.194399] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.194403] pci 0000:00:02.0: reg 20: [io  0x6000-0x603f]
[    0.194467] pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
[    0.194488] pci 0000:00:14.0: reg 10: [mem 0xf3a20000-0xf3a2ffff 64bit]
[    0.194560] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.194583] pci 0000:00:14.0: System wakeup disabled by ACPI
[    0.194617] pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
[    0.194639] pci 0000:00:16.0: reg 10: [mem 0xf3a35000-0xf3a3500f 64bit]
[    0.194713] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.194772] pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
[    0.194789] pci 0000:00:19.0: reg 10: [mem 0xf3a00000-0xf3a1ffff]
[    0.194797] pci 0000:00:19.0: reg 14: [mem 0xf3a3b000-0xf3a3bfff]
[    0.194805] pci 0000:00:19.0: reg 18: [io  0x6080-0x609f]
[    0.194866] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.194883] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.194913] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
[    0.194933] pci 0000:00:1a.0: reg 10: [mem 0xf3a3a000-0xf3a3a3ff]
[    0.195020] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.195047] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.195073] pci 0000:00:1b.0: [8086:1e20] type 00 class 0x040300
[    0.195088] pci 0000:00:1b.0: reg 10: [mem 0xf3a30000-0xf3a33fff 64bit]
[    0.195152] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.195182] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.195213] pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
[    0.195339] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.195398] pci 0000:00:1c.1: [8086:1e12] type 01 class 0x060400
[    0.195525] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.195588] pci 0000:00:1c.2: [8086:1e14] type 01 class 0x060400
[    0.195717] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.195748] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    0.195782] pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
[    0.195802] pci 0000:00:1d.0: reg 10: [mem 0xf3a39000-0xf3a393ff]
[    0.195889] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.195914] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.195943] pci 0000:00:1f.0: [8086:1e55] type 00 class 0x060100
[    0.196078] pci 0000:00:1f.2: [8086:1e03] type 00 class 0x010601
[    0.196095] pci 0000:00:1f.2: reg 10: [io  0x60a8-0x60af]
[    0.196103] pci 0000:00:1f.2: reg 14: [io  0x60b4-0x60b7]
[    0.196110] pci 0000:00:1f.2: reg 18: [io  0x60a0-0x60a7]
[    0.196118] pci 0000:00:1f.2: reg 1c: [io  0x60b0-0x60b3]
[    0.196125] pci 0000:00:1f.2: reg 20: [io  0x6060-0x607f]
[    0.196133] pci 0000:00:1f.2: reg 24: [mem 0xf3a38000-0xf3a387ff]
[    0.196175] pci 0000:00:1f.2: PME# supported from D3hot
[    0.196217] pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
[    0.196232] pci 0000:00:1f.3: reg 10: [mem 0xf3a34000-0xf3a340ff 64bit]
[    0.196252] pci 0000:00:1f.3: reg 20: [io  0xefa0-0xefbf]
[    0.196332] pci 0000:01:00.0: [10de:0ffb] type 00 class 0x030000
[    0.196339] pci 0000:01:00.0: reg 10: [mem 0xf0000000-0xf0ffffff]
[    0.196346] pci 0000:01:00.0: reg 14: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.196353] pci 0000:01:00.0: reg 1c: [mem 0xd0000000-0xd1ffffff 64bit pref]
[    0.196359] pci 0000:01:00.0: reg 24: [io  0x5000-0x507f]
[    0.196364] pci 0000:01:00.0: reg 30: [mem 0xfff80000-0xffffffff pref]
[    0.197578] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.197583] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.197588] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf10fffff]
[    0.197594] pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.197770] pci 0000:02:00.0: [1180:e822] type 00 class 0x088001
[    0.197789] pci 0000:02:00.0: MMC controller base frequency changed to 50Mhz.
[    0.197816] pci 0000:02:00.0: reg 10: [mem 0xf3101000-0xf31010ff]
[    0.198017] pci 0000:02:00.0: supports D1 D2
[    0.198019] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.198145] pci 0000:02:00.3: [1180:e832] type 00 class 0x0c0010
[    0.198171] pci 0000:02:00.3: reg 10: [mem 0xf3100000-0xf31007ff]
[    0.198373] pci 0000:02:00.3: supports D1 D2
[    0.198374] pci 0000:02:00.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.199695] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.199699] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.199703] pci 0000:00:1c.0:   bridge window [mem 0xf3100000-0xf39fffff]
[    0.199711] pci 0000:00:1c.0:   bridge window [mem 0xf1800000-0xf1ffffff 64bit pref]
[    0.199935] pci 0000:03:00.0: [8086:0085] type 00 class 0x028000
[    0.200083] pci 0000:03:00.0: reg 10: [mem 0xf3000000-0xf3001fff 64bit]
[    0.200802] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.202713] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.202722] pci 0000:00:1c.1:   bridge window [mem 0xf3000000-0xf30fffff]
[    0.202810] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
[    0.202814] pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
[    0.202819] pci 0000:00:1c.2:   bridge window [mem 0xf2800000-0xf2ffffff]
[    0.202827] pci 0000:00:1c.2:   bridge window [mem 0xf2000000-0xf27fffff 64bit pref]
[    0.202895] acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
[    0.202965] acpi PNP0A08:00: ACPI _OSC request failed (AE_SUPPORT), returned control mask: 0x0d
[    0.202966] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.203779] ACPI: Enabled 4 GPEs in block 00 to 3F
[    0.203788] acpi root: \_SB_.PCI0 notify handler is installed
[    0.203824] Found 1 acpi root devices
[    0.203871] ACPI: EC: GPE = 0x11, I/O: command/status = 0x66, data = 0x62
[    0.204732] ACPI: ACPI Dock Station Driver: 2 docks/bays found
[    0.204783] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.204788] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=none,locks=none
[    0.204789] vgaarb: loaded
[    0.204789] vgaarb: bridge control possible 0000:01:00.0
[    0.204790] vgaarb: no bridge control possible 0000:00:02.0
[    0.204842] SCSI subsystem initialized
[    0.204843] ACPI: bus type ATA registered
[    0.204867] libata version 3.00 loaded.
[    0.204888] ACPI: bus type USB registered
[    0.204899] usbcore: registered new interface driver usbfs
[    0.204904] usbcore: registered new interface driver hub
[    0.204921] usbcore: registered new device driver usb
[    0.204956] PCI: Using ACPI for IRQ routing
[    0.206630] PCI: pci_cache_line_size set to 64 bytes
[    0.206813] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
[    0.206814] e820: reserve RAM buffer [mem 0x40004000-0x43ffffff]
[    0.206815] e820: reserve RAM buffer [mem 0xa59f4000-0xa7ffffff]
[    0.206816] e820: reserve RAM buffer [mem 0x83e600000-0x83fffffff]
[    0.206879] NetLabel: Initializing
[    0.206880] NetLabel:  domain hash size = 128
[    0.206881] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.206887] NetLabel:  unlabeled traffic allowed by default
[    0.206927] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.206931] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.208949] Switching to clocksource hpet
[    0.212782] pnp: PnP ACPI init
[    0.212789] ACPI: bus type PNP registered
[    0.213088] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.213090] system 00:00: [mem 0x000c0000-0x000c3fff] could not be reserved
[    0.213091] system 00:00: [mem 0x000c4000-0x000c7fff] could not be reserved
[    0.213093] system 00:00: [mem 0x000c8000-0x000cbfff] has been reserved
[    0.213094] system 00:00: [mem 0x000cc000-0x000cffff] has been reserved
[    0.213096] system 00:00: [mem 0x000d0000-0x000d3fff] could not be reserved
[    0.213097] system 00:00: [mem 0x000d4000-0x000d7fff] has been reserved
[    0.213098] system 00:00: [mem 0x000d8000-0x000dbfff] has been reserved
[    0.213100] system 00:00: [mem 0x000dc000-0x000dffff] has been reserved
[    0.213101] system 00:00: [mem 0x000e0000-0x000e3fff] could not be reserved
[    0.213102] system 00:00: [mem 0x000e4000-0x000e7fff] could not be reserved
[    0.213104] system 00:00: [mem 0x000e8000-0x000ebfff] could not be reserved
[    0.213105] system 00:00: [mem 0x000ec000-0x000effff] could not be reserved
[    0.213107] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.213108] system 00:00: [mem 0x00100000-0xbf9fffff] could not be reserved
[    0.213110] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.213111] system 00:00: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.213113] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.213177] pnp 00:01: disabling [mem 0xfffff000-0xffffffff] because it overlaps 0000:01:00.0 BAR 6 [mem 0xfff80000-0xffffffff pref]
[    0.213193] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.213195] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.213196] system 00:01: [io  0x0800-0x080f] has been reserved
[    0.213198] system 00:01: [io  0x15e0-0x15ef] has been reserved
[    0.213199] system 00:01: [io  0x1600-0x167f] has been reserved
[    0.213201] system 00:01: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.213202] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.213204] system 00:01: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.213205] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.213207] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.213208] system 00:01: [mem 0xfed45000-0xfed4bfff] has been reserved
[    0.213210] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.213250] pnp 00:02: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.213257] pnp 00:03: [dma 4]
[    0.213268] pnp 00:03: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.213280] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.213307] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.213324] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.213346] pnp 00:07: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
[    0.213367] pnp 00:08: Plug and Play ACPI device, IDs LEN0015 PNP0f13 (active)
[    0.213401] pnp 00:09: Plug and Play ACPI device, IDs SMO1200 PNP0c31 (active)
[    0.213783] pnp: PnP ACPI: found 10 devices
[    0.213785] ACPI: bus type PNP unregistered
[    0.220022] pci 0000:01:00.0: no compatible bridge window for [mem 0xfff80000-0xffffffff pref]
[    0.220190] pci 0000:01:00.0: BAR 6: assigned [mem 0xf1000000-0xf107ffff pref]
[    0.220192] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.220194] pci 0000:00:01.0:   bridge window [io  0x5000-0x5fff]
[    0.220196] pci 0000:00:01.0:   bridge window [mem 0xf0000000-0xf10fffff]
[    0.220198] pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.220204] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.220207] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.220214] pci 0000:00:1c.0:   bridge window [mem 0xf3100000-0xf39fffff]
[    0.220219] pci 0000:00:1c.0:   bridge window [mem 0xf1800000-0xf1ffffff 64bit pref]
[    0.220227] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.220233] pci 0000:00:1c.1:   bridge window [mem 0xf3000000-0xf30fffff]
[    0.220245] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
[    0.220249] pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
[    0.220258] pci 0000:00:1c.2:   bridge window [mem 0xf2800000-0xf2ffffff]
[    0.220263] pci 0000:00:1c.2:   bridge window [mem 0xf2000000-0xf27fffff 64bit pref]
[    0.220401] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.220403] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.220404] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.220405] pci_bus 0000:00: resource 7 [mem 0xbfa00000-0xfebfffff]
[    0.220407] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed4bfff]
[    0.220408] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
[    0.220409] pci_bus 0000:01: resource 1 [mem 0xf0000000-0xf10fffff]
[    0.220411] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.220412] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    0.220413] pci_bus 0000:02: resource 1 [mem 0xf3100000-0xf39fffff]
[    0.220415] pci_bus 0000:02: resource 2 [mem 0xf1800000-0xf1ffffff 64bit pref]
[    0.220416] pci_bus 0000:03: resource 1 [mem 0xf3000000-0xf30fffff]
[    0.220417] pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
[    0.220419] pci_bus 0000:04: resource 1 [mem 0xf2800000-0xf2ffffff]
[    0.220420] pci_bus 0000:04: resource 2 [mem 0xf2000000-0xf27fffff 64bit pref]
[    0.220450] NET: Registered protocol family 2
[    0.220764] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.221250] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.221359] TCP: Hash tables configured (established 262144 bind 65536)
[    0.221375] TCP: reno registered
[    0.221407] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    0.221496] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    0.221610] NET: Registered protocol family 1
[    0.221620] pci 0000:00:02.0: Boot video device
[    0.221946] PCI: CLS 64 bytes, default 64
[    0.221993] Unpacking initramfs...
[    0.611211] Freeing initrd memory: 29444k freed
[    0.614330] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.614335] software IO TLB [mem 0xa19f4000-0xa59f4000] (64MB) mapped at [ffff8800a19f4000-ffff8800a59f3fff]
[    0.616811] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    0.617087] Initialise system trusted keyring
[    0.617119] audit: initializing netlink socket (disabled)
[    0.617133] type=2000 audit(1425833103.593:1): initialized
[    0.637760] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.639467] VFS: Disk quotas dquot_6.5.2
[    0.639513] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.639777] msgmni has been set to 32768
[    0.639819] SELinux:  Registering netfilter hooks
[    0.640385] alg: No test for stdrng (krng)
[    0.640392] NET: Registered protocol family 38
[    0.640394] Key type asymmetric registered
[    0.640395] Asymmetric key parser 'x509' registered
[    0.640396] Asymmetric key parser 'pefile' registered
[    0.640418] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.640444] io scheduler noop registered
[    0.640445] io scheduler deadline registered
[    0.640451] io scheduler cfq registered (default)
[    0.640555] pcieport 0000:00:01.0: irq 42 for MSI/MSI-X
[    0.640782] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.640792] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.640793] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.640886] acpiphp: Slot [1] registered
[    0.640944] intel_idle: MWAIT substates: 0x21120
[    0.640945] intel_idle: v0.4 model 0x3A
[    0.640946] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.641356] ACPI: AC Adapter [AC] (on-line)
[    0.641418] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.641625] ACPI: Lid Switch [LID]
[    0.641650] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    0.641653] ACPI: Sleep Button [SLPB]
[    0.641695] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.641697] ACPI: Power Button [PWRF]
[    0.641746] ACPI: Requesting acpi_cpufreq
[    0.644793] thermal LNXTHERM:00: registered as thermal_zone0
[    0.644795] ACPI: Thermal Zone [THM0] (57 C)
[    0.644809] GHES: HEST is not enabled!
[    0.644859] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.645229] Non-volatile memory driver v1.3
[    0.645231] Linux agpgart interface v0.103
[    0.645756] loop: module loaded
[    0.645791] ahci 0000:00:1f.2: version 3.0
[    0.645871] ahci 0000:00:1f.2: irq 43 for MSI/MSI-X
[    0.645900] ahci: SSS flag set, parallel bus scan disabled
[    0.645926] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x13 impl SATA mode
[    0.645929] ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pio slum part ems sxs apst 
[    0.645934] ahci 0000:00:1f.2: setting latency timer to 64
[    0.649796] scsi0 : ahci
[    0.649860] scsi1 : ahci
[    0.649905] scsi2 : ahci
[    0.649947] scsi3 : ahci
[    0.649997] scsi4 : ahci
[    0.650032] scsi5 : ahci
[    0.650054] ata1: SATA max UDMA/133 abar m2048@0xf3a38000 port 0xf3a38100 irq 43
[    0.650057] ata2: SATA max UDMA/133 abar m2048@0xf3a38000 port 0xf3a38180 irq 43
[    0.650058] ata3: DUMMY
[    0.650058] ata4: DUMMY
[    0.650060] ata5: SATA max UDMA/133 abar m2048@0xf3a38000 port 0xf3a38300 irq 43
[    0.650061] ata6: DUMMY
[    0.650122] libphy: Fixed MDIO Bus: probed
[    0.650175] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.650176] ehci-pci: EHCI PCI platform driver
[    0.650244] ehci-pci 0000:00:1a.0: setting latency timer to 64
[    0.650247] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    0.650283] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    0.650300] ehci-pci 0000:00:1a.0: debug port 2
[    0.652434] ACPI: Battery Slot [BAT0] (battery present)
[    0.654207] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    0.654220] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf3a3a000
[    0.659539] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    0.659552] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.659554] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.659555] usb usb1: Product: EHCI Host Controller
[    0.659557] usb usb1: Manufacturer: Linux 3.9.5-301.fc19.x86_64 ehci_hcd
[    0.659558] usb usb1: SerialNumber: 0000:00:1a.0
[    0.659634] hub 1-0:1.0: USB hub found
[    0.659637] hub 1-0:1.0: 3 ports detected
[    0.659764] ehci-pci 0000:00:1d.0: setting latency timer to 64
[    0.659767] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.659803] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    0.659816] ehci-pci 0000:00:1d.0: debug port 2
[    0.663708] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    0.663720] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf3a39000
[    0.669549] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.669558] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    0.669559] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.669560] usb usb2: Product: EHCI Host Controller
[    0.669562] usb usb2: Manufacturer: Linux 3.9.5-301.fc19.x86_64 ehci_hcd
[    0.669563] usb usb2: SerialNumber: 0000:00:1d.0
[    0.669630] hub 2-0:1.0: USB hub found
[    0.669633] hub 2-0:1.0: 3 ports detected
[    0.669709] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.669715] uhci_hcd: USB Universal Host Controller Interface driver
[    0.669774] xhci_hcd 0000:00:14.0: setting latency timer to 64
[    0.669777] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.669812] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    0.669900] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.669942] xhci_hcd 0000:00:14.0: irq 44 for MSI/MSI-X
[    0.669982] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    0.669983] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.669984] usb usb3: Product: xHCI Host Controller
[    0.669986] usb usb3: Manufacturer: Linux 3.9.5-301.fc19.x86_64 xhci_hcd
[    0.669987] usb usb3: SerialNumber: 0000:00:14.0
[    0.670044] xHCI xhci_add_endpoint called for root hub
[    0.670046] xHCI xhci_check_bandwidth called for root hub
[    0.670059] hub 3-0:1.0: USB hub found
[    0.670067] hub 3-0:1.0: 4 ports detected
[    0.670315] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.670348] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    0.670367] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    0.670369] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.670370] usb usb4: Product: xHCI Host Controller
[    0.670371] usb usb4: Manufacturer: Linux 3.9.5-301.fc19.x86_64 xhci_hcd
[    0.670372] usb usb4: SerialNumber: 0000:00:14.0
[    0.670425] xHCI xhci_add_endpoint called for root hub
[    0.670426] xHCI xhci_check_bandwidth called for root hub
[    0.670440] hub 4-0:1.0: USB hub found
[    0.670449] hub 4-0:1.0: 4 ports detected
[    0.678577] usbcore: registered new interface driver usbserial
[    0.678582] usbcore: registered new interface driver usbserial_generic
[    0.678586] usbserial: USB Serial support registered for generic
[    0.678607] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.680776] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.680780] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.680832] mousedev: PS/2 mouse device common for all mice
[    0.680970] rtc_cmos 00:06: RTC can wake from S4
[    0.681092] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    0.681128] rtc_cmos 00:06: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.681170] device-mapper: uevent: version 1.0.3
[    0.681215] device-mapper: ioctl: 4.24.0-ioctl (2013-01-15) initialised: dm-devel@redhat.com
[    0.681342] cpuidle: using governor ladder
[    0.681488] cpuidle: using governor menu
[    0.681799] EFI Variables Facility v0.08 2004-May-17
[    0.681807] hidraw: raw HID events driver (C) Jiri Kosina
[    0.681861] usbcore: registered new interface driver usbhid
[    0.681862] usbhid: USB HID core driver
[    0.681877] drop_monitor: Initializing network drop monitor service
[    0.681934] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.681977] TCP: cubic registered
[    0.681982] Initializing XFRM netlink socket
[    0.682059] NET: Registered protocol family 10
[    0.682164] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.682200] mip6: Mobile IPv6
[    0.682201] NET: Registered protocol family 17
[    0.682442] PM: Hibernation image not present or could not be loaded.
[    0.682443] Loading compiled-in X.509 certificates
[    0.683145] Loaded X.509 cert 'Fedora kernel signing key: 78fb4a79e920e6faab7a0c9f59d1d38942b01496'
[    0.683151] registered taskstats version 1
[    0.684524]   Magic number: 7:514:792
[    0.684647] rtc_cmos 00:06: setting system clock to 2015-03-08 16:45:04 UTC (1425833104)
[    0.954962] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.956148] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    0.956155] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    0.956484] ata1.00: supports DRM functions and may not be fully accessible
[    0.956574] ata1.00: ATA-9: Crucial_CT256MX100SSD1, MU01, max UDMA/133
[    0.956592] ata1.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    0.961969] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    0.961983] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    0.961987] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    0.962286] ata1.00: supports DRM functions and may not be fully accessible
[    0.966658] ata1.00: configured for UDMA/133
[    0.966865] scsi 0:0:0:0: Direct-Access     ATA      Crucial_CT256MX1 MU01 PQ: 0 ANSI: 5
[    0.967029] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.967032] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    0.967035] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    0.967281] sd 0:0:0:0: [sda] Write Protect is off
[    0.967283] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.967379] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.968061]  sda: sda1 sda2 sda3
[    0.968898] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.076451] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    1.076457] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.076743] hub 1-1:1.0: USB hub found
[    1.076947] hub 1-1:1.0: 6 ports detected
[    1.180208] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.272355] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.275357] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
[    1.275613] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
[    1.276784] ata2.00: ATAPI: MATSHITADVD-RAM UJ8C0, SB01, max UDMA/133
[    1.279515] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
[    1.279774] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
[    1.280945] ata2.00: configured for UDMA/133
[    1.283157] scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ8C0    SB01 PQ: 0 ANSI: 5
[    1.285371] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    1.285375] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.285555] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.285658] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    1.294696] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    1.294700] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.294991] hub 2-1:1.0: USB hub found
[    1.295067] hub 2-1:1.0: 8 ports detected
[    1.398465] hub 3-0:1.0: unable to enumerate USB device on port 2
[    1.471839] psmouse serio1: synaptics: Touchpad model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd047b3/0xb40000/0xa0000, board id: 71, fw id: 920262
[    1.471843] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[    1.510701] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input4
[    1.590715] ata5: SATA link down (SStatus 0 SControl 300)
[    1.591552] Freeing unused kernel memory: 1352k freed
[    1.591703] Write protecting the kernel read-only data: 12288k
[    1.594694] Freeing unused kernel memory: 1708k freed
[    1.597128] Freeing unused kernel memory: 1332k freed
[    1.599740] systemd[1]: systemd 204 running in system mode. (+PAM +LIBWRAP +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ)
[    1.599810] systemd[1]: Running in initial RAM disk.
[    1.599878] systemd[1]: No hostname configured.
[    1.599882] systemd[1]: Set hostname to <localhost>.
[    1.599947] systemd[1]: Initializing machine ID from random generator.
[    1.603767] systemd[1]: Starting Timers.
[    1.603782] systemd[1]: Reached target Timers.
[    1.603833] systemd[1]: Starting udev Kernel Socket.
[    1.603858] systemd[1]: Listening on udev Kernel Socket.
[    1.603900] systemd[1]: Starting udev Control Socket.
[    1.603929] systemd[1]: Listening on udev Control Socket.
[    1.603941] systemd[1]: Starting Journal Socket.
[    1.603974] systemd[1]: Listening on Journal Socket.
[    1.604090] systemd[1]: Starting dracut cmdline hook...
[    1.604397] systemd[1]: Starting Sockets.
[    1.604410] systemd[1]: Reached target Sockets.
[    1.604423] systemd[1]: Starting Journal Service...
[    1.604746] systemd[1]: Started Journal Service.
[    1.604767] usb 4-2: new SuperSpeed USB device number 2 using xhci_hcd
[    1.605129] systemd[1]: Started Load Kernel Modules.
[    1.605148] systemd[1]: Starting Encrypted Volumes.
[    1.605166] systemd[1]: Reached target Encrypted Volumes.
[    1.605234] systemd[1]: Started Device-Mapper Multipath Device Controller.
[    1.605248] systemd[1]: Starting Swap.
[    1.605264] systemd[1]: Reached target Swap.
[    1.605278] systemd[1]: Starting Local File Systems.
[    1.605295] systemd[1]: Reached target Local File Systems.
[    1.615749] tsc: Refined TSC clocksource calibration: 2793.661 MHz
[    1.615754] Switching to clocksource tsc
[    1.616838] usb 4-2: New USB device found, idVendor=0951, idProduct=1666
[    1.616841] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.616843] usb 4-2: Product: DataTraveler 3.0
[    1.616846] usb 4-2: Manufacturer: Kingston
[    1.616848] usb 4-2: SerialNumber: 08606E6D401FBE20370A5311
[    1.686446] RPC: Registered named UNIX socket transport module.
[    1.686449] RPC: Registered udp transport module.
[    1.686450] RPC: Registered tcp transport module.
[    1.686450] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.689921] usb 1-1.3: new full-speed USB device number 3 using ehci-pci
[    1.741283] systemd-udevd[218]: starting version 204
[    1.745460] Initializing USB Mass Storage driver...
[    1.746282] scsi6 : usb-storage 4-2:1.0
[    1.746584] usbcore: registered new interface driver usb-storage
[    1.746587] USB Mass Storage support registered.
[    1.776019] usb 1-1.3: New USB device found, idVendor=147e, idProduct=2020
[    1.776023] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.776025] usb 1-1.3: Product: Biometric Coprocessor
[    1.776028] usb 1-1.3: Manufacturer: Auth
[    1.794604] wmi: Mapper loaded
[    1.796978] pps_core: LinuxPPS API ver. 1 registered
[    1.796980] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.797919] PTP clock support registered
[    1.800964] [drm] Initialized drm 1.1.0 20060810
[    1.801783] e1000e: Intel(R) PRO/1000 Network Driver - 2.2.14-k
[    1.801785] e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
[    1.801879] e1000e 0000:00:19.0: setting latency timer to 64
[    1.801951] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.801994] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[    1.803806] sdhci: Secure Digital Host Controller Interface driver
[    1.803808] sdhci: Copyright(c) Pierre Ossman
[    1.805262] sdhci-pci 0000:02:00.0: SDHCI controller found [1180:e822] (rev 8)
[    1.823536] alg: No test for crc32 (crc32-pclmul)
[    1.827551] VGA switcheroo: detected Optimus DSM method \_SB_.PCI0.PEG_.VID_ handle
[    1.827579] nouveau 0000:01:00.0: enabling device (0004 -> 0007)
[    1.827883] nouveau  [  DEVICE][0000:01:00.0] BOOT0  : 0x0e73b0a2
[    1.827886] nouveau  [  DEVICE][0000:01:00.0] Chipset: GK107 (NVE7)
[    1.827888] nouveau  [  DEVICE][0000:01:00.0] Family : NVE0
[    1.829605] nouveau  [   VBIOS][0000:01:00.0] checking PRAMIN for image...
[    1.877790] nouveau  [   VBIOS][0000:01:00.0] ... signature not found
[    1.877792] nouveau  [   VBIOS][0000:01:00.0] checking PROM for image...
[    1.877862] nouveau  [   VBIOS][0000:01:00.0] ... signature not found
[    1.877865] nouveau  [   VBIOS][0000:01:00.0] checking ACPI for image...
[    1.878157] usb 1-1.4: new full-speed USB device number 4 using ehci-pci
[    1.878174] mmc0: SDHCI controller on PCI [0000:02:00.0] using DMA
[    1.967013] usb 1-1.4: New USB device found, idVendor=0a5c, idProduct=21e6
[    1.967019] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.967023] usb 1-1.4: Product: BCM20702A0
[    1.967026] usb 1-1.4: Manufacturer: Broadcom Corp
[    1.967029] usb 1-1.4: SerialNumber: B8763FA7FA23
[    2.024283] firewire_ohci 0000:02:00.3: added OHCI v1.10 device as card 0, 4 IR + 4 IT contexts, quirks 0x11
[    2.033628] e1000e 0000:00:19.0 eth0: registered PHC clock
[    2.033631] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 3c:97:0e:c3:c6:6d
[    2.033632] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    2.033666] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 1000FF-0FF
[    2.040383] usb 1-1.6: new high-speed USB device number 5 using ehci-pci
[    2.045345] systemd-udevd[257]: renamed network interface eth0 to em1
[    2.133140] usb 1-1.6: New USB device found, idVendor=5986, idProduct=02d2
[    2.133143] usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.133144] usb 1-1.6: Product: Integrated Camera
[    2.133145] usb 1-1.6: Manufacturer: Ricoh Company Ltd.
[    2.147524] nouveau  [   VBIOS][0000:01:00.0] ... appears to be valid
[    2.147526] nouveau  [   VBIOS][0000:01:00.0] using image from ACPI
[    2.147650] nouveau  [   VBIOS][0000:01:00.0] BIT signature found
[    2.147652] nouveau  [   VBIOS][0000:01:00.0] version 80.07.31.00.18
[    2.147794] nouveau  [ DEVINIT][0000:01:00.0] adaptor not initialised
[    2.147796] nouveau  [   VBIOS][0000:01:00.0] running init tables
[    2.391902] nouveau  [     PFB][0000:01:00.0] RAM type: DDR3
[    2.391904] nouveau  [     PFB][0000:01:00.0] RAM size: 2048 MiB
[    2.391905] nouveau  [     PFB][0000:01:00.0]    ZCOMP: 0 tags
[    2.419800] nouveau  [  PTHERM][0000:01:00.0] FAN control: none / external
[    2.419805] nouveau  [  PTHERM][0000:01:00.0] fan management: disabled
[    2.419816] nouveau  [  PTHERM][0000:01:00.0] internal sensor: yes
[    2.419819] nouveau  [  PTHERM][0000:01:00.0] programmed thresholds [ 90(3), 95(3), 105(5), 135(5) ]
[    2.448877] [TTM] Zone  kernel: Available graphics memory: 16247942 kiB
[    2.448879] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    2.448881] [TTM] Initializing pool allocator
[    2.448884] [TTM] Initializing DMA pool allocator
[    2.448900] mtrr: no more MTRRs available
[    2.448903] nouveau  [     DRM] VRAM: 2048 MiB
[    2.448904] nouveau  [     DRM] GART: 512 MiB
[    2.448907] nouveau  [     DRM] TMDS table version 2.0
[    2.448908] nouveau  [     DRM] DCB version 4.0
[    2.448910] nouveau  [     DRM] DCB outp 00: 01800f23 00010034
[    2.448911] nouveau  [     DRM] DCB outp 01: 02811f00 00000000
[    2.448913] nouveau  [     DRM] DCB outp 02: 02822fa6 0f420010
[    2.448914] nouveau  [     DRM] DCB outp 03: 02822f62 00020010
[    2.448915] nouveau  [     DRM] DCB outp 04: 04833fb6 0f220010
[    2.448917] nouveau  [     DRM] DCB outp 05: 04833f72 00020010
[    2.448918] nouveau  [     DRM] DCB outp 06: 08844fc6 0f220010
[    2.448919] nouveau  [     DRM] DCB outp 07: 08844f82 00020010
[    2.448920] nouveau  [     DRM] DCB conn 00: 00000040
[    2.448922] nouveau  [     DRM] DCB conn 01: 00000100
[    2.448923] nouveau  [     DRM] DCB conn 02: 00010246
[    2.448924] nouveau  [     DRM] DCB conn 03: 00020346
[    2.448925] nouveau  [     DRM] DCB conn 04: 01000446
[    2.450266] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    2.450268] [drm] No driver support for vblank timestamp query.
[    2.450346] nouveau  [     DRM] ACPI backlight interface available, not registering our own
[    2.450372] nouveau W[     DRM] voltage table 0x50 unknown
[    2.450376] nouveau  [     DRM] 2 available performance level(s)
[    2.450378] nouveau  [     DRM] 1: core 202MHz shader 405MHz memory 405MHz voltage 490mV
[    2.450380] nouveau  [     DRM] 3: core 450MHz shader 900MHz memory 1080MHz voltage 560mV
[    2.450381] nouveau  [     DRM] c:
[    2.460991] nouveau  [     DRM] MM: using COPY for buffer copies
[    2.525926] firewire_core 0000:02:00.3: created device fw0: GUID 3c970effc3c66dff, S400
[    2.558897] nouveau 0000:01:00.0: No connectors reported connected with modes
[    2.558899] [drm] Cannot find any crtc or sizes - going 1024x768
[    2.588610] nouveau  [     DRM] allocated 1024x768 fb: 0x80000, bo ffff88080b5d9400
[    2.590019] Console: switching to colour frame buffer device 128x48
[    2.590995] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    2.590996] nouveau 0000:01:00.0: registered panic notifier
[    2.590998] [drm] Initialized nouveau 1.1.0 20120801 for 0000:01:00.0 on minor 0
[    2.591568] [drm] Memory usable by graphics device = 2048M
[    2.591573] i915 0000:00:02.0: setting latency timer to 64
[    2.612867] i915 0000:00:02.0: irq 46 for MSI/MSI-X
[    2.612873] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    2.612874] [drm] Driver supports precise vblank timestamp query.
[    2.613036] vga_switcheroo: enabled
[    2.613077] vgaarb: device changed decodes: PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=none
[    2.613080] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
[    2.690073] [drm] GMBUS [i915 gmbus vga] timed out, falling back to bit banging on pin 2
[    2.705171] fbcon: inteldrmfb (fb1) is primary device
[    2.705172] fbcon: Remapping primary device, fb1, to tty 1-63
[    2.750628] scsi 6:0:0:0: Direct-Access     Kingston DataTraveler 3.0 PMAP PQ: 0 ANSI: 6
[    2.750951] sd 6:0:0:0: Attached scsi generic sg2 type 0
[    2.751199] sd 6:0:0:0: [sdb] 15356160 512-byte logical blocks: (7.86 GB/7.32 GiB)
[    2.751537] sd 6:0:0:0: [sdb] Write Protect is off
[    2.751539] sd 6:0:0:0: [sdb] Mode Sense: 45 00 00 00
[    2.751854] sd 6:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.846973]  sdb: sdb1 sdb2 sdb3
[    2.848503] sd 6:0:0:0: [sdb] Attached SCSI removable disk
[    3.730605] [drm] Enabling RC6 states: RC6 on, RC6p on, RC6pp off
[    3.813294] i915 0000:00:02.0: fb1: inteldrmfb frame buffer device
[    3.826209] acpi device:00: registered as cooling_device8
[    3.826270] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[    3.826303] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
[    3.827237] acpi device:0a: registered as cooling_device9
[    3.827287] ACPI: Video Device [VID1] (multi-head: yes  rom: yes  post: no)
[    3.827315] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:09/LNXVIDEO:01/input/input6
[    3.827385] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 1
[    3.870763] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.895949] ISO 9660 Extensions: Microsoft Joliet Level 3
[    3.897986] ISO 9660 Extensions: RRIP_1991A
[    3.928286] bio: create slab <bio-1> at 1
[    4.087008] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[    4.277117] systemd-journald[119]: Received SIGTERM
[    4.376708] psmouse serio2: alps: Unknown ALPS touchpad: E7=10 00 64, EC=10 00 64
[    4.589048] type=1404 audit(1425833108.398:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[    4.792714] SELinux: 2048 avtab hash slots, 100052 rules.
[    4.805127] SELinux: 2048 avtab hash slots, 100052 rules.
[    4.940093] SELinux:  8 users, 82 roles, 4468 types, 252 bools, 1 sens, 1024 cats
[    4.940096] SELinux:  83 classes, 100052 rules
[    4.944076] SELinux:  Completing initialization.
[    4.944078] SELinux:  Setting up existing superblocks.
[    4.944084] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
[    4.944087] SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
[    4.944095] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
[    4.944099] SELinux: initialized (dev proc, type proc), uses genfs_contexts
[    4.944105] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[    4.944133] SELinux: initialized (dev devtmpfs, type devtmpfs), uses transition SIDs
[    4.944823] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
[    4.944826] SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
[    4.945279] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
[    4.945283] SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts
[    4.945285] SELinux: initialized (dev devpts, type devpts), uses transition SIDs
[    4.945297] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition SIDs
[    4.945301] SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
[    4.945306] SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
[    4.945314] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
[    4.945551] SELinux: initialized (dev securityfs, type securityfs), uses genfs_contexts
[    4.945553] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[    4.945558] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[    4.945639] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[    4.945661] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945665] SELinux: initialized (dev pstore, type pstore), uses genfs_contexts
[    4.945667] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945670] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945686] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945691] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945693] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945696] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945698] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945702] SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
[    4.945705] SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
[    4.945709] SELinux: initialized (dev sdb1, type iso9660), uses genfs_contexts
[    4.945713] SELinux: initialized (dev loop0, type squashfs), uses xattr
[    4.945718] SELinux: initialized (dev loop2, type squashfs), uses xattr
[    4.945726] SELinux: initialized (dev dm-0, type ext4), uses xattr
[    4.968082] type=1403 audit(1425833108.777:3): policy loaded auid=4294967295 ses=4294967295
[    4.972316] systemd[1]: Successfully loaded SELinux policy in 391.630ms.
[    5.022802] systemd[1]: Relabelled /dev and /run in 17.360ms.
[    5.216584] LVM: Logical Volume autoactivation enabled.
[    5.216588] LVM: Activation generator successfully completed.
[    5.446674] SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
[    5.705361] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition SIDs
[    5.705387] SELinux: initialized (dev configfs, type configfs), uses genfs_contexts
[    5.705429] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[    5.716833] EXT4-fs (dm-0): re-mounted. Opts: (null)
[    5.846898] systemd-udevd[550]: starting version 204
[    6.036840] microcode: CPU0 sig=0x306a9, pf=0x10, revision=0x1b
[    6.095027] microcode: CPU1 sig=0x306a9, pf=0x10, revision=0x1b
[    6.095069] microcode: CPU2 sig=0x306a9, pf=0x10, revision=0x1b
[    6.095104] microcode: CPU3 sig=0x306a9, pf=0x10, revision=0x1b
[    6.095134] microcode: CPU4 sig=0x306a9, pf=0x10, revision=0x1b
[    6.095162] microcode: CPU5 sig=0x306a9, pf=0x10, revision=0x1b
[    6.095193] microcode: CPU6 sig=0x306a9, pf=0x10, revision=0x1b
[    6.095222] microcode: CPU7 sig=0x306a9, pf=0x10, revision=0x1b
[    6.095291] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    6.164628] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt
[    6.164894] tpm_tis 00:09: 1.2 TPM (device-id 0x0, rev-id 78)
[    6.168266] ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts with Region \_SB_.PCI0.LPC_.PMIO 1 (20130117/utaddress-251)
[    6.168272] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    6.168280] ACPI Warning: 0x0000000000000530-0x000000000000053f SystemIO conflicts with Region \_SB_.PCI0.LPC_.LPIO 1 (20130117/utaddress-251)
[    6.168283] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    6.168285] ACPI Warning: 0x0000000000000500-0x000000000000052f SystemIO conflicts with Region \_SB_.PCI0.LPC_.LPIO 1 (20130117/utaddress-251)
[    6.168288] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[    6.168290] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    6.188640] mei 0000:00:16.0: setting latency timer to 64
[    6.188707] mei 0000:00:16.0: irq 47 for MSI/MSI-X
[    6.212468] tpm_tis 00:09: TPM is disabled/deactivated (0x6)
[    6.240101] thinkpad_acpi: ThinkPad ACPI Extras v0.24
[    6.240104] thinkpad_acpi: http://ibm-acpi.sf.net/
[    6.240105] thinkpad_acpi: ThinkPad BIOS G5ETA1WW (2.61 ), EC unknown
[    6.240106] thinkpad_acpi: Lenovo ThinkPad W530, model 244150G
[    6.240401] thinkpad_acpi: detected a 8-level brightness capable ThinkPad
[    6.240578] thinkpad_acpi: radio switch found; radios are enabled
[    6.240589] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    6.240590] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    6.241760] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    6.241993] iTCO_vendor_support: vendor-support=0
[    6.242146] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
[    6.242284] thinkpad_acpi: Console audio control enabled, mode: monitor (read only)
[    6.242964] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input7
[    6.250375] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[    6.250408] iTCO_wdt: Found a Panther Point TCO device (Version=2, TCOBASE=0x0460)
[    6.250500] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    6.486288] media: Linux media interface: v0.10
[    6.490838] systemd-udevd[569]: renamed network interface em1 to enp0s25
[    6.490881] cfg80211: Calling CRDA to update world regulatory domain
[    6.615885] Linux video capture interface: v2.00
[    6.716616] snd_hda_intel 0000:00:1b.0: irq 48 for MSI/MSI-X
[    6.787975] Intel(R) Wireless WiFi driver for Linux, in-tree:d
[    6.787979] Copyright(c) 2003-2013 Intel Corporation
[    6.788485] iwlwifi 0000:03:00.0: irq 49 for MSI/MSI-X
[    6.808407] bio: create slab <bio-2> at 2
[    6.826617] ALSA sound/pci/hda/patch_realtek.c:394 SKU: Nid=0x1d sku_cfg=0x40138205
[    6.826619] ALSA sound/pci/hda/patch_realtek.c:396 SKU: port_connectivity=0x1
[    6.826620] ALSA sound/pci/hda/patch_realtek.c:397 SKU: enable_pcbeep=0x1
[    6.826621] ALSA sound/pci/hda/patch_realtek.c:398 SKU: check_sum=0x00000003
[    6.826621] ALSA sound/pci/hda/patch_realtek.c:399 SKU: customization=0x00000082
[    6.826622] ALSA sound/pci/hda/patch_realtek.c:400 SKU: external_amp=0x0
[    6.826623] ALSA sound/pci/hda/patch_realtek.c:401 SKU: platform_type=0x1
[    6.826624] ALSA sound/pci/hda/patch_realtek.c:402 SKU: swap=0x0
[    6.826624] ALSA sound/pci/hda/patch_realtek.c:403 SKU: override=0x1
[    6.826929] ALSA sound/pci/hda/hda_auto_parser.c:335 autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    6.826930] ALSA sound/pci/hda/hda_auto_parser.c:339    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    6.826931] ALSA sound/pci/hda/hda_auto_parser.c:343    hp_outs=2 (0x15/0x1b/0x0/0x0/0x0)
[    6.826932] ALSA sound/pci/hda/hda_auto_parser.c:344    mono: mono_out=0x0
[    6.826933] ALSA sound/pci/hda/hda_auto_parser.c:348    inputs:
[    6.826934] ALSA sound/pci/hda/hda_auto_parser.c:352      Mic=0x18
[    6.826935] ALSA sound/pci/hda/hda_auto_parser.c:352      Dock Mic=0x19
[    6.826936] ALSA sound/pci/hda/hda_auto_parser.c:352      Internal Mic=0x12
[    6.826937] ALSA sound/pci/hda/patch_realtek.c:466 realtek: No valid SSID, checking pincfg 0x40138205 for NID 0x1d
[    6.826938] ALSA sound/pci/hda/patch_realtek.c:482 realtek: Enabling init ASM_ID=0x8205 CODEC_ID=10ec0269
[    6.832414] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[    6.832545] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    6.832616] input: HDA Intel PCH Dock Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[    6.832670] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[    6.913034] uvcvideo: Found UVC 1.00 device Integrated Camera (5986:02d2)
[    6.914970] input: Integrated Camera as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/input/input12
[    6.915026] usbcore: registered new interface driver uvcvideo
[    6.915027] USB Video Class driver (1.1.1)
[    6.936795] Bluetooth: Core ver 2.16
[    6.936810] NET: Registered protocol family 31
[    6.936811] Bluetooth: HCI device and connection manager initialized
[    6.936818] Bluetooth: HCI socket layer initialized
[    6.936819] Bluetooth: L2CAP socket layer initialized
[    6.936823] Bluetooth: SCO socket layer initialized
[    6.959983] cfg80211: World regulatory domain updated:
[    6.959986] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[    6.959987] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    6.959988] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    6.959989] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[    6.959989] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    6.959990] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    6.967199] usbcore: registered new interface driver btusb
[    6.989646] iwlwifi 0000:03:00.0: loaded firmware version 18.168.6.1
[    7.026910] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[    7.027561] type=1305 audit(1425833110.833:4): audit_pid=610 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[    7.027802] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
[    7.253185] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUG enabled
[    7.253187] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUGFS enabled
[    7.253188] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
[    7.253189] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TESTMODE disabled
[    7.253190] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_P2P disabled
[    7.253192] iwlwifi 0000:03:00.0: Detected Intel(R) Centrino(R) Advanced-N 6205 AGN, REV=0xB0
[    7.253242] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[    7.295539] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[    7.320928] systemd-udevd[565]: renamed network interface wlan0 to wlp3s0
[    7.457127] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.457129] Bluetooth: BNEP filters: protocol multicast
[    7.457136] Bluetooth: BNEP socket layer initialized
[    7.469376] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
[    7.489166] Bluetooth: RFCOMM TTY layer initialized
[    7.489176] Bluetooth: RFCOMM socket layer initialized
[    7.489177] Bluetooth: RFCOMM ver 1.11
[    7.662894] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input13
[    7.900772] nouveau E[  PGRAPH][0000:01:00.0] ROP0 ch 1 [0x000007fc92 DRM] 0x80000000 0x80000001
[    7.900793] nouveau E[  PGRAPH][0000:01:00.0] ROP1 ch 1 [0x000007fc92 DRM] 0x80000000 0x80000001
[    8.669511] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    8.703789] Ebtables v2.0 registered
[    8.739029] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    8.925942] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[    9.026982] e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
[    9.027159] IPv6: ADDRCONF(NETDEV_UP): enp0s25: link is not ready
[    9.062037] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[    9.068623] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
[    9.436183] iwlwifi 0000:03:00.0: L1 Enabled; Disabling L0S
[    9.442777] iwlwifi 0000:03:00.0: Radio type=0x1-0x2-0x0
[    9.647794] IPv6: ADDRCONF(NETDEV_UP): wlp3s0: link is not ready
[   11.764391] fuse init (API version 7.21)
[   11.771723] SELinux: initialized (dev fuse, type fuse), uses genfs_contexts
[   11.772886] SELinux: initialized (dev fusectl, type fusectl), uses genfs_contexts
[  172.747871] wlp3s0: authenticate with 2c:95:7f:40:b1:60
[  172.758387] wlp3s0: send auth to 2c:95:7f:40:b1:60 (try 1/3)
[  172.768957] wlp3s0: authenticated
[  172.770366] wlp3s0: associate with 2c:95:7f:40:b1:60 (try 1/3)
[  172.789055] wlp3s0: RX AssocResp from 2c:95:7f:40:b1:60 (capab=0x411 status=0 aid=2)
[  172.821150] wlp3s0: associated
[  172.821216] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes ready
[  531.598913] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=dmesg_fedora_21.txt
Content-Transfer-Encoding: quoted-printable

-- Logs begin at Thu 2015-03-05 21:16:03 CET, end at Thu 2015-03-05 23:43:0=
5 CET. --
Mar 06 00:38:56 localhost.localdomain systemd-journal[185]: Runtime journal=
 is using 8.0M (max allowed 1.5G, trying to leave 2.3G free of 15.4G availa=
ble =E2=86=92 current limit 1.5G).
Mar 06 00:38:56 localhost.localdomain systemd-journal[185]: Runtime journal=
 is using 8.0M (max allowed 1.5G, trying to leave 2.3G free of 15.4G availa=
ble =E2=86=92 current limit 1.5G).
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys cp=
uset
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys cpu
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys cp=
uacct
Mar 06 00:38:56 localhost.localdomain kernel: Linux version 3.18.7-200.fc21=
.x86_64 (mockbuild@bkernel02.phx2.fedoraproject.org) (gcc version 4.9.2 201=
41101 (Red Hat 4.9.2-1) (GCC) ) #1 SMP Wed Feb 11 21:53:17 UTC 2015
Mar 06 00:38:56 localhost.localdomain kernel: Command line: BOOT_IMAGE=3D/b=
oot/vmlinuz-3.18.7-200.fc21.x86_64 root=3D/dev/mapper/fedora-root ro rd.lvm=
.lv=3Dfedora/root rhgb quiet LANG=3Den_DK.UTF-8 crashkernel=3D128M drm.debu=
g=3D14 log_buf_len=3D16M
Mar 06 00:38:56 localhost.localdomain kernel: e820: BIOS-provided physical =
RAM map:
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000000=
00000-0x000000000009d7ff] usable
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000000=
9d800-0x000000000009ffff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000000=
e0000-0x00000000000fffff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000001=
00000-0x000000001fffffff] usable
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000200=
00000-0x00000000201fffff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000202=
00000-0x0000000040003fff] usable
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000400=
04000-0x0000000040004fff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000400=
05000-0x00000000c6b2ffff] usable
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000c6b=
30000-0x00000000dae9efff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000dae=
9f000-0x00000000daf9efff] ACPI NVS
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000daf=
9f000-0x00000000daffefff] ACPI data
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000daf=
ff000-0x00000000df9fffff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000f80=
00000-0x00000000fbffffff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000fec=
00000-0x00000000fec00fff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000fed=
08000-0x00000000fed08fff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000fed=
10000-0x00000000fed19fff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000fed=
1c000-0x00000000fed1ffff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000fee=
00000-0x00000000fee00fff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000000ffc=
00000-0x00000000ffffffff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x00000001000=
00000-0x000000081e5fffff] usable
Mar 06 00:38:56 localhost.localdomain kernel: BIOS-e820: [mem 0x000000081e6=
00000-0x000000081fffffff] reserved
Mar 06 00:38:56 localhost.localdomain kernel: NX (Execute Disable) protecti=
on: active
Mar 06 00:38:56 localhost.localdomain kernel: SMBIOS 2.7 present.
Mar 06 00:38:56 localhost.localdomain kernel: DMI: LENOVO 244150G/244150G, =
BIOS G5ETA1WW (2.61 ) 01/22/2015
Mar 06 00:38:56 localhost.localdomain kernel: e820: update [mem 0x00000000-=
0x00000fff] usable =3D=3D> reserved
Mar 06 00:38:56 localhost.localdomain kernel: e820: remove [mem 0x000a0000-=
0x000fffff] usable
Mar 06 00:38:56 localhost.localdomain kernel: e820: last_pfn =3D 0x81e600 m=
ax_arch_pfn =3D 0x400000000
Mar 06 00:38:56 localhost.localdomain kernel: MTRR default type: uncachable
Mar 06 00:38:56 localhost.localdomain kernel: MTRR fixed ranges enabled:
Mar 06 00:38:56 localhost.localdomain kernel:   00000-9FFFF write-back
Mar 06 00:38:56 localhost.localdomain kernel:   A0000-BFFFF uncachable
Mar 06 00:38:56 localhost.localdomain kernel:   C0000-FFFFF write-protect
Mar 06 00:38:56 localhost.localdomain kernel: MTRR variable ranges enabled:
Mar 06 00:38:56 localhost.localdomain kernel:   0 base 0FFC00000 mask FFFC0=
0000 write-protect
Mar 06 00:38:56 localhost.localdomain kernel:   1 base 000000000 mask F8000=
0000 write-back
Mar 06 00:38:56 localhost.localdomain kernel:   2 base 080000000 mask FC000=
0000 write-back
Mar 06 00:38:56 localhost.localdomain kernel:   3 base 0C0000000 mask FE000=
0000 write-back
Mar 06 00:38:56 localhost.localdomain kernel:   4 base 0DC000000 mask FFC00=
0000 uncachable
Mar 06 00:38:56 localhost.localdomain kernel:   5 base 0DB000000 mask FFF00=
0000 uncachable
Mar 06 00:38:56 localhost.localdomain kernel:   6 base 100000000 mask F0000=
0000 write-back
Mar 06 00:38:56 localhost.localdomain kernel:   7 base 200000000 mask E0000=
0000 write-back
Mar 06 00:38:56 localhost.localdomain kernel:   8 base 400000000 mask C0000=
0000 write-back
Mar 06 00:38:56 localhost.localdomain kernel:   9 base 800000000 mask FE000=
0000 write-back
Mar 06 00:38:56 localhost.localdomain kernel: x86 PAT enabled: cpu 0, old 0=
x7040600070406, new 0x7010600070106
Mar 06 00:38:56 localhost.localdomain kernel: e820: last_pfn =3D 0xc6b30 ma=
x_arch_pfn =3D 0x400000000
Mar 06 00:38:56 localhost.localdomain kernel: found SMP MP-table at [mem 0x=
000f0100-0x000f010f] mapped at [ffff8800000f0100]
Mar 06 00:38:56 localhost.localdomain kernel: Base memory trampoline at [ff=
ff880000097000] 97000 size 24576
Mar 06 00:38:56 localhost.localdomain kernel: init_memory_mapping: [mem 0x0=
0000000-0x000fffff]
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x00000000-0x000fffff] =
page 4k
Mar 06 00:38:56 localhost.localdomain kernel: BRK [0x0203a000, 0x0203afff] =
PGTABLE
Mar 06 00:38:56 localhost.localdomain kernel: BRK [0x0203b000, 0x0203bfff] =
PGTABLE
Mar 06 00:38:56 localhost.localdomain kernel: BRK [0x0203c000, 0x0203cfff] =
PGTABLE
Mar 06 00:38:56 localhost.localdomain kernel: init_memory_mapping: [mem 0x8=
1e400000-0x81e5fffff]
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x81e400000-0x81e5fffff=
] page 2M
Mar 06 00:38:56 localhost.localdomain kernel: BRK [0x0203d000, 0x0203dfff] =
PGTABLE
Mar 06 00:38:56 localhost.localdomain kernel: init_memory_mapping: [mem 0x8=
1c000000-0x81e3fffff]
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x81c000000-0x81e3fffff=
] page 2M
Mar 06 00:38:56 localhost.localdomain kernel: init_memory_mapping: [mem 0x8=
00000000-0x81bffffff]
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x800000000-0x81bffffff=
] page 2M
Mar 06 00:38:56 localhost.localdomain kernel: init_memory_mapping: [mem 0x0=
0100000-0x1fffffff]
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x00100000-0x001fffff] =
page 4k
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x00200000-0x1fffffff] =
page 2M
Mar 06 00:38:56 localhost.localdomain kernel: init_memory_mapping: [mem 0x2=
0200000-0x40003fff]
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x20200000-0x3fffffff] =
page 2M
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x40000000-0x40003fff] =
page 4k
Mar 06 00:38:56 localhost.localdomain kernel: BRK [0x0203e000, 0x0203efff] =
PGTABLE
Mar 06 00:38:56 localhost.localdomain kernel: BRK [0x0203f000, 0x0203ffff] =
PGTABLE
Mar 06 00:38:56 localhost.localdomain kernel: init_memory_mapping: [mem 0x4=
0005000-0xc6b2ffff]
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x40005000-0x401fffff] =
page 4k
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x40200000-0xc69fffff] =
page 2M
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0xc6a00000-0xc6b2ffff] =
page 4k
Mar 06 00:38:56 localhost.localdomain kernel: init_memory_mapping: [mem 0x1=
00000000-0x7ffffffff]
Mar 06 00:38:56 localhost.localdomain kernel:  [mem 0x100000000-0x7ffffffff=
] page 2M
Mar 06 00:38:56 localhost.localdomain kernel: log_buf_len: 16777216 bytes
Mar 06 00:38:56 localhost.localdomain kernel: early log buf free: 256808(97=
%)
Mar 06 00:38:56 localhost.localdomain kernel: RAMDISK: [mem 0x35b39000-0x36=
d94fff]
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Early table checksum ve=
rification disabled
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: RSDP 0x00000000000F0120=
 000024 (v02 LENOVO)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: XSDT 0x00000000DAFFE170=
 0000C4 (v01 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: FACP 0x00000000DAFE6000=
 00010C (v05 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: DSDT 0x00000000DAFE8000=
 010FD9 (v01 LENOVO TP-G5    00002610 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: FACS 0x00000000DAF54000=
 000040
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SLIC 0x00000000DAFFD000=
 000176 (v01 LENOVO TP-G5    00002610 PTL  00000001)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: TCPA 0x00000000DAFFC000=
 000032 (v02 PTL    LENOVO   06040000 LNVO 00000001)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SSDT 0x00000000DAFFB000=
 000408 (v01 LENOVO TP-SSDT2 00000200 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SSDT 0x00000000DAFFA000=
 000033 (v01 LENOVO TP-SSDT1 00000100 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SSDT 0x00000000DAFF9000=
 000797 (v01 LENOVO SataAhci 00001000 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: HPET 0x00000000DAFE4000=
 000038 (v01 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: APIC 0x00000000DAFE3000=
 000098 (v01 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: MCFG 0x00000000DAFE2000=
 00003C (v01 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: ECDT 0x00000000DAFE1000=
 000052 (v01 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: FPDT 0x00000000DAFE0000=
 000064 (v01 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: ASF! 0x00000000DAFE7000=
 0000A5 (v32 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: UEFI 0x00000000DAFDF000=
 00003E (v01 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: UEFI 0x00000000DAFDE000=
 000042 (v01 PTL    COMBUF   00000001 PTL  00000001)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: POAT 0x00000000DAFDD000=
 000055 (v03 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SSDT 0x00000000DAFDC000=
 000D23 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SSDT 0x00000000DAFDB000=
 000A83 (v01 PmRef  CpuPm    00003000 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: DMAR 0x00000000DAFDA000=
 0000B8 (v01 INTEL  SNB      00000001 INTL 00000001)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: UEFI 0x00000000DAFD9000=
 0002A6 (v01 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: DBG2 0x00000000DAFD8000=
 0000E9 (v00 LENOVO TP-G5    00002610 PTL  00000002)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Local APIC address 0xfe=
e00000
Mar 06 00:38:56 localhost.localdomain kernel: No NUMA configuration found
Mar 06 00:38:56 localhost.localdomain kernel: Faking a node at [mem 0x00000=
00000000000-0x000000081e5fffff]
Mar 06 00:38:56 localhost.localdomain kernel: NODE_DATA(0) allocated [mem 0=
x81d5cd000-0x81d5e0fff]
Mar 06 00:38:56 localhost.localdomain kernel: Reserving 128MB of memory at =
720MB for crashkernel (System RAM: 32334MB)
Mar 06 00:38:56 localhost.localdomain kernel:  [ffffea0000000000-ffffea0020=
7fffff] PMD -> [ffff8807fd200000-ffff88081cbfffff] on node 0
Mar 06 00:38:56 localhost.localdomain kernel: Zone ranges:
Mar 06 00:38:56 localhost.localdomain kernel:   DMA      [mem 0x00001000-0x=
00ffffff]
Mar 06 00:38:56 localhost.localdomain kernel:   DMA32    [mem 0x01000000-0x=
ffffffff]
Mar 06 00:38:56 localhost.localdomain kernel:   Normal   [mem 0x100000000-0=
x81e5fffff]
Mar 06 00:38:56 localhost.localdomain kernel: Movable zone start for each n=
ode
Mar 06 00:38:56 localhost.localdomain kernel: Early memory node ranges
Mar 06 00:38:56 localhost.localdomain kernel:   node   0: [mem 0x00001000-0=
x0009cfff]
Mar 06 00:38:56 localhost.localdomain kernel:   node   0: [mem 0x00100000-0=
x1fffffff]
Mar 06 00:38:56 localhost.localdomain kernel:   node   0: [mem 0x20200000-0=
x40003fff]
Mar 06 00:38:56 localhost.localdomain kernel:   node   0: [mem 0x40005000-0=
xc6b2ffff]
Mar 06 00:38:56 localhost.localdomain kernel:   node   0: [mem 0x100000000-=
0x81e5fffff]
Mar 06 00:38:56 localhost.localdomain kernel: Initmem setup node 0 [mem 0x0=
0001000-0x81e5fffff]
Mar 06 00:38:56 localhost.localdomain kernel: On node 0 totalpages: 8277707
Mar 06 00:38:56 localhost.localdomain kernel:   DMA zone: 64 pages used for=
 memmap
Mar 06 00:38:56 localhost.localdomain kernel:   DMA zone: 21 pages reserved
Mar 06 00:38:56 localhost.localdomain kernel:   DMA zone: 3996 pages, LIFO =
batch:0
Mar 06 00:38:56 localhost.localdomain kernel:   DMA32 zone: 12645 pages use=
d for memmap
Mar 06 00:38:56 localhost.localdomain kernel:   DMA32 zone: 809263 pages, L=
IFO batch:31
Mar 06 00:38:56 localhost.localdomain kernel:   Normal zone: 116632 pages u=
sed for memmap
Mar 06 00:38:56 localhost.localdomain kernel:   Normal zone: 7464448 pages,=
 LIFO batch:31
Mar 06 00:38:56 localhost.localdomain kernel: Reserving Intel graphics stol=
en memory at 0xdba00000-0xdf9fffff
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PM-Timer IO Port: 0x408
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Local APIC address 0xfe=
e00000
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC (acpi_id[0x01] la=
pic_id[0x00] enabled)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC (acpi_id[0x02] la=
pic_id[0x01] enabled)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC (acpi_id[0x03] la=
pic_id[0x02] enabled)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC (acpi_id[0x04] la=
pic_id[0x03] enabled)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC (acpi_id[0x05] la=
pic_id[0x04] enabled)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC (acpi_id[0x06] la=
pic_id[0x05] enabled)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC (acpi_id[0x07] la=
pic_id[0x06] enabled)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC (acpi_id[0x08] la=
pic_id[0x07] enabled)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC_NMI (acpi_id[0x00=
] high edge lint[0x1])
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: LAPIC_NMI (acpi_id[0x01=
] high edge lint[0x1])
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: IOAPIC (id[0x02] addres=
s[0xfec00000] gsi_base[0])
Mar 06 00:38:56 localhost.localdomain kernel: IOAPIC[0]: apic_id 2, version=
 32, address 0xfec00000, GSI 0-23
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: INT_SRC_OVR (bus 0 bus_=
irq 0 global_irq 2 dfl dfl)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: INT_SRC_OVR (bus 0 bus_=
irq 9 global_irq 9 high level)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: IRQ0 used by override.
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: IRQ9 used by override.
Mar 06 00:38:56 localhost.localdomain kernel: Using ACPI (MADT) for SMP con=
figuration information
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: HPET id: 0x8086a301 bas=
e: 0xfed00000
Mar 06 00:38:56 localhost.localdomain kernel: smpboot: Allowing 8 CPUs, 0 h=
otplug CPUs
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0x00000000-0x00000fff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0x0009d000-0x0009dfff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0x0009e000-0x0009ffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0x000a0000-0x000dffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0x000e0000-0x000fffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0x20000000-0x201fffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0x40004000-0x40004fff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xc6b30000-0xdae9efff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xdae9f000-0xdaf9efff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xdaf9f000-0xdaffefff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xdafff000-0xdf9fffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xdfa00000-0xf7ffffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xf8000000-0xfbffffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfc000000-0xfebfffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfec00000-0xfec00fff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfec01000-0xfed07fff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfed08000-0xfed08fff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfed09000-0xfed0ffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfed10000-0xfed19fff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfed1a000-0xfed1bfff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfed1c000-0xfed1ffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfed20000-0xfedfffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfee00000-0xfee00fff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xfee01000-0xffbfffff]
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registered nosave memory:=
 [mem 0xffc00000-0xffffffff]
Mar 06 00:38:56 localhost.localdomain kernel: e820: [mem 0xdfa00000-0xf7fff=
fff] available for PCI devices
Mar 06 00:38:56 localhost.localdomain kernel: Booting paravirtualized kerne=
l on bare hardware
Mar 06 00:38:56 localhost.localdomain kernel: setup_percpu: NR_CPUS:1024 nr=
_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
Mar 06 00:38:56 localhost.localdomain kernel: PERCPU: Embedded 30 pages/cpu=
 @ffff88081d200000 s84480 r8192 d30208 u262144
Mar 06 00:38:56 localhost.localdomain kernel: pcpu-alloc: s84480 r8192 d302=
08 u262144 alloc=3D1*2097152
Mar 06 00:38:56 localhost.localdomain kernel: pcpu-alloc: [0] 0 1 2 3 4 5 6=
 7=20
Mar 06 00:38:56 localhost.localdomain kernel: Built 1 zonelists in Node ord=
er, mobility grouping on.  Total pages: 8148345
Mar 06 00:38:56 localhost.localdomain kernel: Policy zone: Normal
Mar 06 00:38:56 localhost.localdomain kernel: Kernel command line: BOOT_IMA=
GE=3D/boot/vmlinuz-3.18.7-200.fc21.x86_64 root=3D/dev/mapper/fedora-root ro=
 rd.lvm.lv=3Dfedora/root rhgb quiet LANG=3Den_DK.UTF-8 crashkernel=3D128M d=
rm.debug=3D14 log_buf_len=3D16M
Mar 06 00:38:56 localhost.localdomain kernel: PID hash table entries: 4096 =
(order: 3, 32768 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: xsave: enabled xstate_bv 0x7,=
 cntxt size 0x340 using standard form
Mar 06 00:38:56 localhost.localdomain kernel: Memory: 32342224K/33110828K a=
vailable (7593K kernel code, 1235K rwdata, 3276K rodata, 1500K init, 1552K =
bss, 768604K reserved)
Mar 06 00:38:56 localhost.localdomain kernel: SLUB: HWalign=3D64, Order=3D0=
-3, MinObjects=3D0, CPUs=3D8, Nodes=3D1
Mar 06 00:38:56 localhost.localdomain kernel: Hierarchical RCU implementati=
on.
Mar 06 00:38:56 localhost.localdomain kernel:         RCU dyntick-idle grac=
e-period acceleration is enabled.
Mar 06 00:38:56 localhost.localdomain kernel:         RCU restricting CPUs =
from NR_CPUS=3D1024 to nr_cpu_ids=3D8.
Mar 06 00:38:56 localhost.localdomain kernel: RCU: Adjusting geometry for r=
cu_fanout_leaf=3D16, nr_cpu_ids=3D8
Mar 06 00:38:56 localhost.localdomain kernel: NR_IRQS:65792 nr_irqs:488 0
Mar 06 00:38:56 localhost.localdomain kernel:         Offload RCU callbacks=
 from all CPUs
Mar 06 00:38:56 localhost.localdomain kernel:         Offload RCU callbacks=
 from CPUs: 0-7.
Mar 06 00:38:56 localhost.localdomain kernel: Console: colour VGA+ 80x25
Mar 06 00:38:56 localhost.localdomain kernel: console [tty0] enabled
Mar 06 00:38:56 localhost.localdomain kernel: allocated 132644864 bytes of =
page_cgroup
Mar 06 00:38:56 localhost.localdomain kernel: please try 'cgroup_disable=3D=
memory' option if you don't want memory cgroups
Mar 06 00:38:56 localhost.localdomain kernel: hpet clockevent registered
Mar 06 00:38:56 localhost.localdomain kernel: tsc: Fast TSC calibration usi=
ng PIT
Mar 06 00:38:56 localhost.localdomain kernel: tsc: Detected 2793.889 MHz pr=
ocessor
Mar 06 00:38:56 localhost.localdomain kernel: Calibrating delay loop (skipp=
ed), value calculated using timer frequency.. 5587.77 BogoMIPS (lpj=3D27938=
89)
Mar 06 00:38:56 localhost.localdomain kernel: pid_max: default: 32768 minim=
um: 301
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Core revision 20140926
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: All ACPI Tables success=
fully acquired
Mar 06 00:38:56 localhost.localdomain kernel: Security Framework initialized
Mar 06 00:38:56 localhost.localdomain kernel: SELinux:  Initializing.
Mar 06 00:38:56 localhost.localdomain kernel: SELinux:  Starting in permiss=
ive mode
Mar 06 00:38:56 localhost.localdomain kernel: Dentry cache hash table entri=
es: 4194304 (order: 13, 33554432 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: Inode-cache hash table entrie=
s: 2097152 (order: 12, 16777216 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: Mount-cache hash table entrie=
s: 65536 (order: 7, 524288 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: Mountpoint-cache hash table e=
ntries: 65536 (order: 7, 524288 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys me=
mory
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys de=
vices
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys fr=
eezer
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys ne=
t_cls
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys bl=
kio
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys pe=
rf_event
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys ne=
t_prio
Mar 06 00:38:56 localhost.localdomain kernel: Initializing cgroup subsys hu=
getlb
Mar 06 00:38:56 localhost.localdomain kernel: CPU: Physical Processor ID: 0
Mar 06 00:38:56 localhost.localdomain kernel: CPU: Processor Core ID: 0
Mar 06 00:38:56 localhost.localdomain kernel: ENERGY_PERF_BIAS: Set to 'nor=
mal', was 'performance'
                                              ENERGY_PERF_BIAS: View and up=
date with x86_energy_perf_policy(8)
Mar 06 00:38:56 localhost.localdomain kernel: mce: CPU supports 9 MCE banks
Mar 06 00:38:56 localhost.localdomain kernel: CPU0: Thermal monitoring enab=
led (TM1)
Mar 06 00:38:56 localhost.localdomain kernel: Last level iTLB entries: 4KB =
512, 2MB 8, 4MB 8
                                              Last level dTLB entries: 4KB =
512, 2MB 32, 4MB 32, 1GB 0
Mar 06 00:38:56 localhost.localdomain kernel: Freeing SMP alternatives memo=
ry: 28K (ffffffff81ead000 - ffffffff81eb4000)
Mar 06 00:38:56 localhost.localdomain kernel: ftrace: allocating 27471 entr=
ies in 108 pages
Mar 06 00:38:56 localhost.localdomain kernel: dmar: Host address width 36
Mar 06 00:38:56 localhost.localdomain kernel: dmar: DRHD base: 0x000000fed9=
0000 flags: 0x0
Mar 06 00:38:56 localhost.localdomain kernel: dmar: IOMMU 0: reg_base_addr =
fed90000 ver 1:0 cap c0000020e60262 ecap f0101a
Mar 06 00:38:56 localhost.localdomain kernel: dmar: DRHD base: 0x000000fed9=
1000 flags: 0x1
Mar 06 00:38:56 localhost.localdomain kernel: dmar: IOMMU 1: reg_base_addr =
fed91000 ver 1:0 cap c9008020660262 ecap f0105a
Mar 06 00:38:56 localhost.localdomain kernel: dmar: RMRR base: 0x000000da3b=
a000 end: 0x000000da3d0fff
Mar 06 00:38:56 localhost.localdomain kernel: dmar: RMRR base: 0x000000db80=
0000 end: 0x000000df9fffff
Mar 06 00:38:56 localhost.localdomain kernel: IOAPIC id 2 under DRHD base  =
0xfed91000 IOMMU 1
Mar 06 00:38:56 localhost.localdomain kernel: HPET id 0 under DRHD base 0xf=
ed91000
Mar 06 00:38:56 localhost.localdomain kernel: Queued invalidation will be e=
nabled to support x2apic and Intr-remapping.
Mar 06 00:38:56 localhost.localdomain kernel: Enabled IRQ remapping in x2ap=
ic mode
Mar 06 00:38:56 localhost.localdomain kernel: Enabling x2apic
Mar 06 00:38:56 localhost.localdomain kernel: Enabled x2apic
Mar 06 00:38:56 localhost.localdomain kernel: Switched APIC routing to clus=
ter x2apic.
Mar 06 00:38:56 localhost.localdomain kernel: ..TIMER: vector=3D0x30 apic1=
=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
Mar 06 00:38:56 localhost.localdomain kernel: smpboot: CPU0: Intel(R) Core(=
TM) i7-3840QM CPU @ 2.80GHz (fam: 06, model: 3a, stepping: 09)
Mar 06 00:38:56 localhost.localdomain kernel: TSC deadline timer enabled
Mar 06 00:38:56 localhost.localdomain kernel: Performance Events: PEBS fmt1=
+, 16-deep LBR, IvyBridge events, full-width counters, Intel PMU driver.
Mar 06 00:38:56 localhost.localdomain kernel: ... version:                3
Mar 06 00:38:56 localhost.localdomain kernel: ... bit width:              48
Mar 06 00:38:56 localhost.localdomain kernel: ... generic registers:      4
Mar 06 00:38:56 localhost.localdomain kernel: ... value mask:             0=
000ffffffffffff
Mar 06 00:38:56 localhost.localdomain kernel: ... max period:             0=
000ffffffffffff
Mar 06 00:38:56 localhost.localdomain kernel: ... fixed-purpose events:   3
Mar 06 00:38:56 localhost.localdomain kernel: ... event mask:             0=
00000070000000f
Mar 06 00:38:56 localhost.localdomain kernel: x86: Booting SMP configuratio=
n:
Mar 06 00:38:56 localhost.localdomain kernel: .... node  #0, CPUs:      #1
Mar 06 00:38:56 localhost.localdomain kernel: NMI watchdog: enabled on all =
CPUs, permanently consumes one hw-PMU counter.
Mar 06 00:38:56 localhost.localdomain kernel:  #2 #3 #4 #5 #6 #7
Mar 06 00:38:56 localhost.localdomain kernel: x86: Booted up 1 node, 8 CPUs
Mar 06 00:38:56 localhost.localdomain kernel: smpboot: Total of 8 processor=
s activated (44702.22 BogoMIPS)
Mar 06 00:38:56 localhost.localdomain kernel: devtmpfs: initialized
Mar 06 00:38:56 localhost.localdomain kernel: PM: Registering ACPI NVS regi=
on [mem 0xdae9f000-0xdaf9efff] (1048576 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: atomic64_test: passed for x86=
-64 platform with CX8 and with SSE
Mar 06 00:38:56 localhost.localdomain kernel: pinctrl core: initialized pin=
ctrl subsystem
Mar 06 00:38:56 localhost.localdomain kernel: RTC time: 23:38:54, date: 03/=
05/15
Mar 06 00:38:56 localhost.localdomain kernel: NET: Registered protocol fami=
ly 16
Mar 06 00:38:56 localhost.localdomain kernel: cpuidle: using governor menu
Mar 06 00:38:56 localhost.localdomain kernel: ACPI FADT declares the system=
 doesn't support PCIe ASPM, so disable it
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: bus type PCI registered
Mar 06 00:38:56 localhost.localdomain kernel: acpiphp: ACPI Hot Plug PCI Co=
ntroller Driver version: 0.5
Mar 06 00:38:56 localhost.localdomain kernel: PCI: MMCONFIG for domain 0000=
 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
Mar 06 00:38:56 localhost.localdomain kernel: PCI: MMCONFIG at [mem 0xf8000=
000-0xfbffffff] reserved in E820
Mar 06 00:38:56 localhost.localdomain kernel: PCI: Using configuration type=
 1 for base access
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Added _OSI(Module Devic=
e)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Added _OSI(Processor De=
vice)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Added _OSI(3.0 _SCP Ext=
ensions)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Added _OSI(Processor Ag=
gregator Device)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI : EC: EC description tab=
le is found, configuring boot EC
Mar 06 00:38:56 localhost.localdomain kernel: [Firmware Bug]: ACPI: BIOS _O=
SI(Linux) query ignored
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Dynamic OEM Table Load:
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SSDT 0xFFFF8807F1588000=
 000A01 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Dynamic OEM Table Load:
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SSDT 0xFFFF8807F1188C00=
 000303 (v01 PmRef  ApIst    00003000 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Dynamic OEM Table Load:
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: SSDT 0xFFFF8807F1184000=
 000119 (v01 PmRef  ApCst    00003000 INTL 20061109)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Interpreter enabled
Mar 06 00:38:56 localhost.localdomain kernel: ACPI Exception: AE_NOT_FOUND,=
 While evaluating Sleep State [\_S1_] (20140926/hwxface-580)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI Exception: AE_NOT_FOUND,=
 While evaluating Sleep State [\_S2_] (20140926/hwxface-580)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: (supports S0 S3 S4 S5)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Using IOAPIC for interr=
upt routing
Mar 06 00:38:56 localhost.localdomain kernel: PCI: Using host bridge window=
s from ACPI; if necessary, use "pci=3Dnocrs" and report a bug
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Power Resource [PUBS] (=
on)
Mar 06 00:38:56 localhost.localdomain kernel: acpi PNP0C0A:01: ACPI dock st=
ation (docks/bays count: 1)
Mar 06 00:38:56 localhost.localdomain kernel: acpi LNXIOBAY:00: ACPI dock s=
tation (docks/bays count: 2)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Interrupt Link [LNK=
A] (IRQs 3 4 5 6 7 9 10 *11)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Interrupt Link [LNK=
B] (IRQs 3 4 5 6 7 9 *10 11)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Interrupt Link [LNK=
C] (IRQs 3 4 5 6 *7 9 10 11)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Interrupt Link [LNK=
D] (IRQs 3 4 5 6 7 9 10 *11)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Interrupt Link [LNK=
E] (IRQs 3 4 5 6 *7 9 10 11)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Interrupt Link [LNK=
F] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Interrupt Link [LNK=
G] (IRQs 3 4 5 6 7 9 10 *11)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Interrupt Link [LNK=
H] (IRQs 3 4 5 6 7 9 *10 11)
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: PCI Root Bridge [PCI0] =
(domain 0000 [bus 00-3f])
Mar 06 00:38:56 localhost.localdomain kernel: acpi PNP0A08:00: _OSC: OS sup=
ports [ExtendedConfig ASPM ClockPM Segments MSI]
Mar 06 00:38:56 localhost.localdomain kernel: acpi PNP0A08:00: _OSC: platfo=
rm does not support [PCIeCapability]
Mar 06 00:38:56 localhost.localdomain kernel: acpi PNP0A08:00: _OSC: not re=
questing control; platform does not support [PCIeCapability]
Mar 06 00:38:56 localhost.localdomain kernel: acpi PNP0A08:00: _OSC: OS req=
uested [PCIeHotplug PME AER PCIeCapability]
Mar 06 00:38:56 localhost.localdomain kernel: acpi PNP0A08:00: _OSC: platfo=
rm willing to grant [PCIeHotplug PME AER]
Mar 06 00:38:56 localhost.localdomain kernel: acpi PNP0A08:00: _OSC failed =
(AE_SUPPORT); disabling ASPM
Mar 06 00:38:56 localhost.localdomain kernel: PCI host bridge to bus 0000:00
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: root bus res=
ource [bus 00-3f]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: root bus res=
ource [io  0x0000-0x0cf7]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: root bus res=
ource [io  0x0d00-0xffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: root bus res=
ource [mem 0x000a0000-0x000bffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: root bus res=
ource [mem 0xdfa00000-0xfebfffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: root bus res=
ource [mem 0xfed40000-0xfed4bfff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:00.0: [8086:0154]=
 type 00 class 0x060000
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:02.0: [8086:0166]=
 type 00 class 0x030000
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:02.0: reg 0x10: [=
mem 0xf0000000-0xf03fffff 64bit]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:02.0: reg 0x18: [=
mem 0xe0000000-0xefffffff 64bit pref]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:02.0: reg 0x20: [=
io  0x5000-0x503f]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:14.0: [8086:1e31]=
 type 00 class 0x0c0330
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:14.0: reg 0x10: [=
mem 0xf2620000-0xf262ffff 64bit]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:14.0: PME# suppor=
ted from D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:14.0: System wake=
up disabled by ACPI
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:16.0: [8086:1e3a]=
 type 00 class 0x078000
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:16.0: reg 0x10: [=
mem 0xf2635000-0xf263500f 64bit]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:16.0: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:19.0: [8086:1502]=
 type 00 class 0x020000
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:19.0: reg 0x10: [=
mem 0xf2600000-0xf261ffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:19.0: reg 0x14: [=
mem 0xf263b000-0xf263bfff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:19.0: reg 0x18: [=
io  0x5080-0x509f]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:19.0: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:19.0: System wake=
up disabled by ACPI
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1a.0: [8086:1e2d]=
 type 00 class 0x0c0320
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1a.0: reg 0x10: [=
mem 0xf263a000-0xf263a3ff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1a.0: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1a.0: System wake=
up disabled by ACPI
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1b.0: [8086:1e20]=
 type 00 class 0x040300
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1b.0: reg 0x10: [=
mem 0xf2630000-0xf2633fff 64bit]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1b.0: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1b.0: System wake=
up disabled by ACPI
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0: [8086:1e10]=
 type 01 class 0x060400
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.1: [8086:1e12]=
 type 01 class 0x060400
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.1: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2: [8086:1e14]=
 type 01 class 0x060400
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2: System wake=
up disabled by ACPI
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1d.0: [8086:1e26]=
 type 00 class 0x0c0320
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1d.0: reg 0x10: [=
mem 0xf2639000-0xf26393ff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1d.0: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1d.0: System wake=
up disabled by ACPI
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.0: [8086:1e55]=
 type 00 class 0x060100
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.2: [8086:1e03]=
 type 00 class 0x010601
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.2: reg 0x10: [=
io  0x50a8-0x50af]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.2: reg 0x14: [=
io  0x50b4-0x50b7]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.2: reg 0x18: [=
io  0x50a0-0x50a7]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.2: reg 0x1c: [=
io  0x50b0-0x50b3]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.2: reg 0x20: [=
io  0x5060-0x507f]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.2: reg 0x24: [=
mem 0xf2638000-0xf26387ff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.2: PME# suppor=
ted from D3hot
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.3: [8086:1e22]=
 type 00 class 0x0c0500
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.3: reg 0x10: [=
mem 0xf2634000-0xf26340ff 64bit]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1f.3: reg 0x20: [=
io  0xefa0-0xefbf]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.0: [1180:e822]=
 type 00 class 0x088001
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.0: MMC control=
ler base frequency changed to 50Mhz.
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.0: reg 0x10: [=
mem 0xf1d01000-0xf1d010ff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.0: supports D1=
 D2
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.0: PME# suppor=
ted from D0 D1 D2 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.3: [1180:e832]=
 type 00 class 0x0c0010
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.3: reg 0x10: [=
mem 0xf1d00000-0xf1d007ff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.3: supports D1=
 D2
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:02:00.3: PME# suppor=
ted from D0 D1 D2 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0: PCI bridge =
to [bus 02]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0:   bridge wi=
ndow [io  0x4000-0x4fff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0:   bridge wi=
ndow [mem 0xf1d00000-0xf25fffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0:   bridge wi=
ndow [mem 0xf0400000-0xf0bfffff 64bit pref]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:03:00.0: [8086:0085]=
 type 00 class 0x028000
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:03:00.0: reg 0x10: [=
mem 0xf1c00000-0xf1c01fff 64bit]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:03:00.0: PME# suppor=
ted from D0 D3hot D3cold
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.1: PCI bridge =
to [bus 03]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.1:   bridge wi=
ndow [mem 0xf1c00000-0xf1cfffff]
Mar 06 00:38:56 localhost.localdomain kernel: acpiphp: Slot [1] registered
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2: PCI bridge =
to [bus 04-0b]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2:   bridge wi=
ndow [io  0x3000-0x3fff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2:   bridge wi=
ndow [mem 0xf1400000-0xf1bfffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2:   bridge wi=
ndow [mem 0xf0c00000-0xf13fffff 64bit pref]
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Enabled 4 GPEs in block=
 00 to 3F
Mar 06 00:38:56 localhost.localdomain kernel: ACPI : EC: GPE =3D 0x11, I/O:=
 command/status =3D 0x66, data =3D 0x62
Mar 06 00:38:56 localhost.localdomain kernel: vgaarb: setting as boot devic=
e: PCI:0000:00:02.0
Mar 06 00:38:56 localhost.localdomain kernel: vgaarb: device added: PCI:000=
0:00:02.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
Mar 06 00:38:56 localhost.localdomain kernel: vgaarb: loaded
Mar 06 00:38:56 localhost.localdomain kernel: vgaarb: bridge control possib=
le 0000:00:02.0
Mar 06 00:38:56 localhost.localdomain kernel: SCSI subsystem initialized
Mar 06 00:38:56 localhost.localdomain kernel: libata version 3.00 loaded.
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: bus type USB registered
Mar 06 00:38:56 localhost.localdomain kernel: usbcore: registered new inter=
face driver usbfs
Mar 06 00:38:56 localhost.localdomain kernel: usbcore: registered new inter=
face driver hub
Mar 06 00:38:56 localhost.localdomain kernel: usbcore: registered new devic=
e driver usb
Mar 06 00:38:56 localhost.localdomain kernel: PCI: Using ACPI for IRQ routi=
ng
Mar 06 00:38:56 localhost.localdomain kernel: PCI: pci_cache_line_size set =
to 64 bytes
Mar 06 00:38:56 localhost.localdomain kernel: e820: reserve RAM buffer [mem=
 0x0009d800-0x0009ffff]
Mar 06 00:38:56 localhost.localdomain kernel: e820: reserve RAM buffer [mem=
 0x40004000-0x43ffffff]
Mar 06 00:38:56 localhost.localdomain kernel: e820: reserve RAM buffer [mem=
 0xc6b30000-0xc7ffffff]
Mar 06 00:38:56 localhost.localdomain kernel: e820: reserve RAM buffer [mem=
 0x81e600000-0x81fffffff]
Mar 06 00:38:56 localhost.localdomain kernel: NetLabel: Initializing
Mar 06 00:38:56 localhost.localdomain kernel: NetLabel:  domain hash size =
=3D 128
Mar 06 00:38:56 localhost.localdomain kernel: NetLabel:  protocols =3D UNLA=
BELED CIPSOv4
Mar 06 00:38:56 localhost.localdomain kernel: NetLabel:  unlabeled traffic =
allowed by default
Mar 06 00:38:56 localhost.localdomain kernel: hpet0: at MMIO 0xfed00000, IR=
Qs 2, 8, 0, 0, 0, 0, 0, 0
Mar 06 00:38:56 localhost.localdomain kernel: hpet0: 8 comparators, 64-bit =
14.318180 MHz counter
Mar 06 00:38:56 localhost.localdomain kernel: Switched to clocksource hpet
Mar 06 00:38:56 localhost.localdomain kernel: pnp: PnP ACPI init
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x00000000=
-0x0009ffff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000c0000=
-0x000c3fff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000c4000=
-0x000c7fff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000c8000=
-0x000cbfff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000cc000=
-0x000cffff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000d0000=
-0x000d3fff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000d4000=
-0x000d7fff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000d8000=
-0x000dbfff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000dc000=
-0x000dffff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000e0000=
-0x000e3fff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000e4000=
-0x000e7fff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000e8000=
-0x000ebfff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000ec000=
-0x000effff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x000f0000=
-0x000fffff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0x00100000=
-0xdf9fffff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0xfec00000=
-0xfed3ffff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: [mem 0xfed4c000=
-0xffffffff] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:00: Plug and Play A=
CPI device, IDs PNP0c01 (active)
Mar 06 00:38:56 localhost.localdomain kernel: pnp 00:01: [Firmware Bug]: PN=
P resource [mem 0xfed10000-0xfed13fff] covers only part of 0000:00:00.0 Int=
el MCH; extending to [mem 0xfed10000-0xfed17fff]
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [io  0x0400-0x0=
47f] could not be reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [io  0x0500-0x0=
57f] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [io  0x0800-0x0=
80f] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [io  0x15e0-0x1=
5ef] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [io  0x1600-0x1=
67f] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [mem 0xf8000000=
-0xfbffffff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [mem 0xfffff000=
-0xffffffff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [mem 0xfed1c000=
-0xfed1ffff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [mem 0xfed10000=
-0xfed17fff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [mem 0xfed18000=
-0xfed18fff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [mem 0xfed19000=
-0xfed19fff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: [mem 0xfed45000=
-0xfed4bfff] has been reserved
Mar 06 00:38:56 localhost.localdomain kernel: system 00:01: Plug and Play A=
CPI device, IDs PNP0c02 (active)
Mar 06 00:38:56 localhost.localdomain kernel: pnp 00:02: Plug and Play ACPI=
 device, IDs PNP0b00 (active)
Mar 06 00:38:56 localhost.localdomain kernel: pnp 00:03: Plug and Play ACPI=
 device, IDs LEN0071 PNP0303 (active)
Mar 06 00:38:56 localhost.localdomain kernel: pnp 00:04: Plug and Play ACPI=
 device, IDs LEN0015 PNP0f13 (active)
Mar 06 00:38:56 localhost.localdomain kernel: pnp 00:05: Plug and Play ACPI=
 device, IDs SMO1200 PNP0c31 (active)
Mar 06 00:38:56 localhost.localdomain kernel: pnp: PnP ACPI: found 6 devices
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0: PCI bridge =
to [bus 02]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0:   bridge wi=
ndow [io  0x4000-0x4fff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0:   bridge wi=
ndow [mem 0xf1d00000-0xf25fffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.0:   bridge wi=
ndow [mem 0xf0400000-0xf0bfffff 64bit pref]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.1: PCI bridge =
to [bus 03]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.1:   bridge wi=
ndow [mem 0xf1c00000-0xf1cfffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2: PCI bridge =
to [bus 04-0b]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2:   bridge wi=
ndow [io  0x3000-0x3fff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2:   bridge wi=
ndow [mem 0xf1400000-0xf1bfffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:1c.2:   bridge wi=
ndow [mem 0xf0c00000-0xf13fffff 64bit pref]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: resource 4 [=
io  0x0000-0x0cf7]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: resource 5 [=
io  0x0d00-0xffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: resource 6 [=
mem 0x000a0000-0x000bffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: resource 7 [=
mem 0xdfa00000-0xfebfffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:00: resource 8 [=
mem 0xfed40000-0xfed4bfff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:02: resource 0 [=
io  0x4000-0x4fff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:02: resource 1 [=
mem 0xf1d00000-0xf25fffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:02: resource 2 [=
mem 0xf0400000-0xf0bfffff 64bit pref]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:03: resource 1 [=
mem 0xf1c00000-0xf1cfffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:04: resource 0 [=
io  0x3000-0x3fff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:04: resource 1 [=
mem 0xf1400000-0xf1bfffff]
Mar 06 00:38:56 localhost.localdomain kernel: pci_bus 0000:04: resource 2 [=
mem 0xf0c00000-0xf13fffff 64bit pref]
Mar 06 00:38:56 localhost.localdomain kernel: NET: Registered protocol fami=
ly 2
Mar 06 00:38:56 localhost.localdomain kernel: TCP established hash table en=
tries: 262144 (order: 9, 2097152 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: TCP bind hash table entries: =
65536 (order: 8, 1048576 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: TCP: Hash tables configured (=
established 262144 bind 65536)
Mar 06 00:38:56 localhost.localdomain kernel: TCP: reno registered
Mar 06 00:38:56 localhost.localdomain kernel: UDP hash table entries: 16384=
 (order: 7, 524288 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: UDP-Lite hash table entries: =
16384 (order: 7, 524288 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: NET: Registered protocol fami=
ly 1
Mar 06 00:38:56 localhost.localdomain kernel: pci 0000:00:02.0: Video devic=
e with shadowed ROM
Mar 06 00:38:56 localhost.localdomain kernel: PCI: CLS 64 bytes, default 64
Mar 06 00:38:56 localhost.localdomain kernel: Unpacking initramfs...
Mar 06 00:38:56 localhost.localdomain kernel: Freeing initrd memory: 18800K=
 (ffff880035b39000 - ffff880036d95000)
Mar 06 00:38:56 localhost.localdomain kernel: PCI-DMA: Using software bounc=
e buffering for IO (SWIOTLB)
Mar 06 00:38:56 localhost.localdomain kernel: software IO TLB [mem 0xc2b300=
00-0xc6b30000] (64MB) mapped at [ffff8800c2b30000-ffff8800c6b2ffff]
Mar 06 00:38:56 localhost.localdomain kernel: RAPL PMU detected, hw unit 2^=
-16 Joules, API unit is 2^-32 Joules, 3 fixed counters 163840 ms ovfl timer
Mar 06 00:38:56 localhost.localdomain kernel: microcode: CPU0 sig=3D0x306a9=
, pf=3D0x10, revision=3D0x1b
Mar 06 00:38:56 localhost.localdomain kernel: microcode: CPU1 sig=3D0x306a9=
, pf=3D0x10, revision=3D0x1b
Mar 06 00:38:56 localhost.localdomain kernel: microcode: CPU2 sig=3D0x306a9=
, pf=3D0x10, revision=3D0x1b
Mar 06 00:38:56 localhost.localdomain kernel: microcode: CPU3 sig=3D0x306a9=
, pf=3D0x10, revision=3D0x1b
Mar 06 00:38:56 localhost.localdomain kernel: microcode: CPU4 sig=3D0x306a9=
, pf=3D0x10, revision=3D0x1b
Mar 06 00:38:56 localhost.localdomain kernel: microcode: CPU5 sig=3D0x306a9=
, pf=3D0x10, revision=3D0x1b
Mar 06 00:38:56 localhost.localdomain kernel: microcode: CPU6 sig=3D0x306a9=
, pf=3D0x10, revision=3D0x1b
Mar 06 00:38:56 localhost.localdomain kernel: microcode: CPU7 sig=3D0x306a9=
, pf=3D0x10, revision=3D0x1b
Mar 06 00:38:56 localhost.localdomain kernel: microcode: Microcode Update D=
river: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
Mar 06 00:38:56 localhost.localdomain kernel: AVX version of gcm_enc/dec en=
gaged.
Mar 06 00:38:56 localhost.localdomain kernel: AES CTR mode by8 optimization=
 enabled
Mar 06 00:38:56 localhost.localdomain kernel: alg: No test for __gcm-aes-ae=
sni (__driver-gcm-aes-aesni)
Mar 06 00:38:56 localhost.localdomain kernel: futex hash table entries: 204=
8 (order: 5, 131072 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: Initialise system trusted key=
ring
Mar 06 00:38:56 localhost.localdomain kernel: audit: initializing netlink s=
ubsys (disabled)
Mar 06 00:38:56 localhost.localdomain kernel: audit: type=3D2000 audit(1425=
598734.846:1): initialized
Mar 06 00:38:56 localhost.localdomain kernel: HugeTLB registered 2 MB page =
size, pre-allocated 0 pages
Mar 06 00:38:56 localhost.localdomain kernel: zpool: loaded
Mar 06 00:38:56 localhost.localdomain kernel: zbud: loaded
Mar 06 00:38:56 localhost.localdomain kernel: VFS: Disk quotas dquot_6.5.2
Mar 06 00:38:56 localhost.localdomain kernel: Dquot-cache hash table entrie=
s: 512 (order 0, 4096 bytes)
Mar 06 00:38:56 localhost.localdomain kernel: msgmni has been set to 32768
Mar 06 00:38:56 localhost.localdomain kernel: Key type big_key registered
Mar 06 00:38:56 localhost.localdomain kernel: SELinux:  Registering netfilt=
er hooks
Mar 06 00:38:56 localhost.localdomain kernel: alg: No test for stdrng (krng)
Mar 06 00:38:56 localhost.localdomain kernel: NET: Registered protocol fami=
ly 38
Mar 06 00:38:56 localhost.localdomain kernel: Key type asymmetric registered
Mar 06 00:38:56 localhost.localdomain kernel: Asymmetric key parser 'x509' =
registered
Mar 06 00:38:56 localhost.localdomain kernel: Block layer SCSI generic (bsg=
) driver version 0.4 loaded (major 252)
Mar 06 00:38:56 localhost.localdomain kernel: io scheduler noop registered
Mar 06 00:38:56 localhost.localdomain kernel: io scheduler deadline registe=
red
Mar 06 00:38:56 localhost.localdomain kernel: io scheduler cfq registered (=
default)
Mar 06 00:38:56 localhost.localdomain kernel: pci_hotplug: PCI Hot Plug PCI=
 Core version: 0.5
Mar 06 00:38:56 localhost.localdomain kernel: pciehp: PCI Express Hot Plug =
Controller Driver version: 0.4
Mar 06 00:38:56 localhost.localdomain kernel: intel_idle: MWAIT substates: =
0x21120
Mar 06 00:38:56 localhost.localdomain kernel: intel_idle: v0.4 model 0x3A
Mar 06 00:38:56 localhost.localdomain kernel: intel_idle: lapic_timer_relia=
ble_states 0xffffffff
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: AC Adapter [AC] (off-li=
ne)
Mar 06 00:38:56 localhost.localdomain kernel: input: Lid Switch as /devices=
/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Lid Switch [LID]
Mar 06 00:38:56 localhost.localdomain kernel: input: Sleep Button as /devic=
es/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Sleep Button [SLPB]
Mar 06 00:38:56 localhost.localdomain kernel: input: Power Button as /devic=
es/LNXSYSTM:00/LNXPWRBN:00/input/input2
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Power Button [PWRF]
Mar 06 00:38:56 localhost.localdomain kernel: thermal LNXTHERM:00: register=
ed as thermal_zone0
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Thermal Zone [THM0] (49=
 C)
Mar 06 00:38:56 localhost.localdomain kernel: GHES: HEST is not enabled!
Mar 06 00:38:56 localhost.localdomain kernel: Serial: 8250/16550 driver, 4 =
ports, IRQ sharing enabled
Mar 06 00:38:56 localhost.localdomain kernel: Non-volatile memory driver v1=
.3
Mar 06 00:38:56 localhost.localdomain kernel: Linux agpgart interface v0.103
Mar 06 00:38:56 localhost.localdomain kernel: ahci 0000:00:1f.2: version 3.0
Mar 06 00:38:56 localhost.localdomain kernel: ahci 0000:00:1f.2: irq 26 for=
 MSI/MSI-X
Mar 06 00:38:56 localhost.localdomain kernel: ahci 0000:00:1f.2: SSS flag s=
et, parallel bus scan disabled
Mar 06 00:38:56 localhost.localdomain kernel: ahci 0000:00:1f.2: AHCI 0001.=
0300 32 slots 6 ports 6 Gbps 0x13 impl SATA mode
Mar 06 00:38:56 localhost.localdomain kernel: ahci 0000:00:1f.2: flags: 64b=
it ncq ilck stag pm led clo pio slum part ems sxs apst=20
Mar 06 00:38:56 localhost.localdomain kernel: scsi host0: ahci
Mar 06 00:38:56 localhost.localdomain kernel: scsi host1: ahci
Mar 06 00:38:56 localhost.localdomain kernel: scsi host2: ahci
Mar 06 00:38:56 localhost.localdomain kernel: scsi host3: ahci
Mar 06 00:38:56 localhost.localdomain kernel: scsi host4: ahci
Mar 06 00:38:56 localhost.localdomain kernel: scsi host5: ahci
Mar 06 00:38:56 localhost.localdomain kernel: ata1: SATA max UDMA/133 abar =
m2048@0xf2638000 port 0xf2638100 irq 26
Mar 06 00:38:56 localhost.localdomain kernel: ata2: SATA max UDMA/133 abar =
m2048@0xf2638000 port 0xf2638180 irq 26
Mar 06 00:38:56 localhost.localdomain kernel: ata3: DUMMY
Mar 06 00:38:56 localhost.localdomain kernel: ata4: DUMMY
Mar 06 00:38:56 localhost.localdomain kernel: ata5: SATA max UDMA/133 abar =
m2048@0xf2638000 port 0xf2638300 irq 26
Mar 06 00:38:56 localhost.localdomain kernel: ata6: DUMMY
Mar 06 00:38:56 localhost.localdomain kernel: libphy: Fixed MDIO Bus: probed
Mar 06 00:38:56 localhost.localdomain kernel: xhci_hcd 0000:00:14.0: xHCI H=
ost Controller
Mar 06 00:38:56 localhost.localdomain kernel: xhci_hcd 0000:00:14.0: new US=
B bus registered, assigned bus number 1
Mar 06 00:38:56 localhost.localdomain kernel: xhci_hcd 0000:00:14.0: cache =
line size of 64 is not supported
Mar 06 00:38:56 localhost.localdomain kernel: xhci_hcd 0000:00:14.0: irq 27=
 for MSI/MSI-X
Mar 06 00:38:56 localhost.localdomain kernel: usb usb1: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0002
Mar 06 00:38:56 localhost.localdomain kernel: usb usb1: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Mar 06 00:38:56 localhost.localdomain kernel: usb usb1: Product: xHCI Host =
Controller
Mar 06 00:38:56 localhost.localdomain kernel: usb usb1: Manufacturer: Linux=
 3.18.7-200.fc21.x86_64 xhci-hcd
Mar 06 00:38:56 localhost.localdomain kernel: usb usb1: SerialNumber: 0000:=
00:14.0
Mar 06 00:38:56 localhost.localdomain kernel: hub 1-0:1.0: USB hub found
Mar 06 00:38:56 localhost.localdomain kernel: hub 1-0:1.0: 4 ports detected
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Battery Slot [BAT0] (ba=
ttery present)
Mar 06 00:38:56 localhost.localdomain kernel: xhci_hcd 0000:00:14.0: xHCI H=
ost Controller
Mar 06 00:38:56 localhost.localdomain kernel: xhci_hcd 0000:00:14.0: new US=
B bus registered, assigned bus number 2
Mar 06 00:38:56 localhost.localdomain kernel: usb usb2: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0003
Mar 06 00:38:56 localhost.localdomain kernel: usb usb2: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Mar 06 00:38:56 localhost.localdomain kernel: usb usb2: Product: xHCI Host =
Controller
Mar 06 00:38:56 localhost.localdomain kernel: usb usb2: Manufacturer: Linux=
 3.18.7-200.fc21.x86_64 xhci-hcd
Mar 06 00:38:56 localhost.localdomain kernel: usb usb2: SerialNumber: 0000:=
00:14.0
Mar 06 00:38:56 localhost.localdomain kernel: hub 2-0:1.0: USB hub found
Mar 06 00:38:56 localhost.localdomain kernel: hub 2-0:1.0: 4 ports detected
Mar 06 00:38:56 localhost.localdomain kernel: ehci_hcd: USB 2.0 'Enhanced' =
Host Controller (EHCI) Driver
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci: EHCI PCI platform d=
river
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1a.0: EHCI H=
ost Controller
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1a.0: new US=
B bus registered, assigned bus number 3
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1a.0: debug =
port 2
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1a.0: cache =
line size of 64 is not supported
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1a.0: irq 16=
, io mem 0xf263a000
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1a.0: USB 2.=
0 started, EHCI 1.00
Mar 06 00:38:56 localhost.localdomain kernel: usb usb3: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0002
Mar 06 00:38:56 localhost.localdomain kernel: usb usb3: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Mar 06 00:38:56 localhost.localdomain kernel: usb usb3: Product: EHCI Host =
Controller
Mar 06 00:38:56 localhost.localdomain kernel: usb usb3: Manufacturer: Linux=
 3.18.7-200.fc21.x86_64 ehci_hcd
Mar 06 00:38:56 localhost.localdomain kernel: usb usb3: SerialNumber: 0000:=
00:1a.0
Mar 06 00:38:56 localhost.localdomain kernel: hub 3-0:1.0: USB hub found
Mar 06 00:38:56 localhost.localdomain kernel: hub 3-0:1.0: 3 ports detected
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1d.0: EHCI H=
ost Controller
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1d.0: new US=
B bus registered, assigned bus number 4
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1d.0: debug =
port 2
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1d.0: cache =
line size of 64 is not supported
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1d.0: irq 23=
, io mem 0xf2639000
Mar 06 00:38:56 localhost.localdomain kernel: ehci-pci 0000:00:1d.0: USB 2.=
0 started, EHCI 1.00
Mar 06 00:38:56 localhost.localdomain kernel: usb usb4: New USB device foun=
d, idVendor=3D1d6b, idProduct=3D0002
Mar 06 00:38:56 localhost.localdomain kernel: usb usb4: New USB device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1
Mar 06 00:38:56 localhost.localdomain kernel: usb usb4: Product: EHCI Host =
Controller
Mar 06 00:38:56 localhost.localdomain kernel: usb usb4: Manufacturer: Linux=
 3.18.7-200.fc21.x86_64 ehci_hcd
Mar 06 00:38:56 localhost.localdomain kernel: usb usb4: SerialNumber: 0000:=
00:1d.0
Mar 06 00:38:56 localhost.localdomain kernel: hub 4-0:1.0: USB hub found
Mar 06 00:38:56 localhost.localdomain kernel: hub 4-0:1.0: 3 ports detected
Mar 06 00:38:56 localhost.localdomain kernel: ohci_hcd: USB 1.1 'Open' Host=
 Controller (OHCI) Driver
Mar 06 00:38:56 localhost.localdomain kernel: ohci-pci: OHCI PCI platform d=
river
Mar 06 00:38:56 localhost.localdomain kernel: uhci_hcd: USB Universal Host =
Controller Interface driver
Mar 06 00:38:56 localhost.localdomain kernel: usbcore: registered new inter=
face driver usbserial
Mar 06 00:38:56 localhost.localdomain kernel: usbcore: registered new inter=
face driver usbserial_generic
Mar 06 00:38:56 localhost.localdomain kernel: usbserial: USB Serial support=
 registered for generic
Mar 06 00:38:56 localhost.localdomain kernel: i8042: PNP: PS/2 Controller [=
PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Mar 06 00:38:56 localhost.localdomain kernel: serio: i8042 KBD port at 0x60=
,0x64 irq 1
Mar 06 00:38:56 localhost.localdomain kernel: serio: i8042 AUX port at 0x60=
,0x64 irq 12
Mar 06 00:38:56 localhost.localdomain kernel: mousedev: PS/2 mouse device c=
ommon for all mice
Mar 06 00:38:56 localhost.localdomain kernel: rtc_cmos 00:02: RTC can wake =
from S4
Mar 06 00:38:56 localhost.localdomain kernel: rtc_cmos 00:02: rtc core: reg=
istered rtc_cmos as rtc0
Mar 06 00:38:56 localhost.localdomain kernel: rtc_cmos 00:02: alarms up to =
one month, y3k, 114 bytes nvram, hpet irqs
Mar 06 00:38:56 localhost.localdomain kernel: device-mapper: uevent: versio=
n 1.0.3
Mar 06 00:38:56 localhost.localdomain kernel: device-mapper: ioctl: 4.28.0-=
ioctl (2014-09-17) initialised: dm-devel@redhat.com
Mar 06 00:38:56 localhost.localdomain kernel: Intel P-state driver initiali=
zing.
Mar 06 00:38:56 localhost.localdomain kernel: input: AT Translated Set 2 ke=
yboard as /devices/platform/i8042/serio0/input/input3
Mar 06 00:38:56 localhost.localdomain kernel: hidraw: raw HID events driver=
 (C) Jiri Kosina
Mar 06 00:38:56 localhost.localdomain kernel: usbcore: registered new inter=
face driver usbhid
Mar 06 00:38:56 localhost.localdomain kernel: usbhid: USB HID core driver
Mar 06 00:38:56 localhost.localdomain kernel: drop_monitor: Initializing ne=
twork drop monitor service
Mar 06 00:38:56 localhost.localdomain kernel: ip_tables: (C) 2000-2006 Netf=
ilter Core Team
Mar 06 00:38:56 localhost.localdomain kernel: TCP: cubic registered
Mar 06 00:38:56 localhost.localdomain kernel: Initializing XFRM netlink soc=
ket
Mar 06 00:38:56 localhost.localdomain kernel: NET: Registered protocol fami=
ly 10
Mar 06 00:38:56 localhost.localdomain kernel: mip6: Mobile IPv6
Mar 06 00:38:56 localhost.localdomain kernel: NET: Registered protocol fami=
ly 17
Mar 06 00:38:56 localhost.localdomain kernel: Loading compiled-in X.509 cer=
tificates
Mar 06 00:38:56 localhost.localdomain kernel: Loaded X.509 cert 'Fedora ker=
nel signing key: c406af3b4a8ec27de35610fad348e54ba39e284a'
Mar 06 00:38:56 localhost.localdomain kernel: registered taskstats version 1
Mar 06 00:38:56 localhost.localdomain kernel:   Magic number: 7:378:655
Mar 06 00:38:56 localhost.localdomain kernel: rtc_cmos 00:02: setting syste=
m clock to 2015-03-05 23:38:55 UTC (1425598735)
Mar 06 00:38:56 localhost.localdomain kernel: PM: Hibernation image not pre=
sent or could not be loaded.
Mar 06 00:38:56 localhost.localdomain kernel: ata1: SATA link up 6.0 Gbps (=
SStatus 133 SControl 300)
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: ACPI cmd ef/02:00:00=
:00:00:a0 (SET FEATURES) succeeded
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: ACPI cmd f5/00:00:00=
:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: supports DRM functio=
ns and may not be fully accessible
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: ATA-9: Crucial_CT256=
MX100SSD1, MU01, max UDMA/133
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: 500118192 sectors, m=
ulti 16: LBA48 NCQ (depth 31/32), AA
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1: new high-speed USB d=
evice number 2 using ehci-pci
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: ACPI cmd ef/02:00:00=
:00:00:a0 (SET FEATURES) succeeded
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: ACPI cmd f5/00:00:00=
:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: supports DRM functio=
ns and may not be fully accessible
Mar 06 00:38:56 localhost.localdomain kernel: ata1.00: configured for UDMA/=
133
Mar 06 00:38:56 localhost.localdomain kernel: scsi 0:0:0:0: Direct-Access  =
   ATA      Crucial_CT256MX1 MU01 PQ: 0 ANSI: 5
Mar 06 00:38:56 localhost.localdomain kernel: usb 4-1: new high-speed USB d=
evice number 2 using ehci-pci
Mar 06 00:38:56 localhost.localdomain kernel: sd 0:0:0:0: [sda] 500118192 5=
12-byte logical blocks: (256 GB/238 GiB)
Mar 06 00:38:56 localhost.localdomain kernel: sd 0:0:0:0: [sda] 4096-byte p=
hysical blocks
Mar 06 00:38:56 localhost.localdomain kernel: sd 0:0:0:0: Attached scsi gen=
eric sg0 type 0
Mar 06 00:38:56 localhost.localdomain kernel: sd 0:0:0:0: [sda] Write Prote=
ct is off
Mar 06 00:38:56 localhost.localdomain kernel: sd 0:0:0:0: [sda] Mode Sense:=
 00 3a 00 00
Mar 06 00:38:56 localhost.localdomain kernel: sd 0:0:0:0: [sda] Write cache=
: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 06 00:38:56 localhost.localdomain kernel:  sda: sda1 sda2 sda3
Mar 06 00:38:56 localhost.localdomain kernel: sd 0:0:0:0: [sda] Attached SC=
SI disk
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1: New USB device found=
, idVendor=3D8087, idProduct=3D0024
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1: New USB device strin=
gs: Mfr=3D0, Product=3D0, SerialNumber=3D0
Mar 06 00:38:56 localhost.localdomain kernel: hub 3-1:1.0: USB hub found
Mar 06 00:38:56 localhost.localdomain kernel: hub 3-1:1.0: 6 ports detected
Mar 06 00:38:56 localhost.localdomain kernel: usb 4-1: New USB device found=
, idVendor=3D8087, idProduct=3D0024
Mar 06 00:38:56 localhost.localdomain kernel: usb 4-1: New USB device strin=
gs: Mfr=3D0, Product=3D0, SerialNumber=3D0
Mar 06 00:38:56 localhost.localdomain kernel: hub 4-1:1.0: USB hub found
Mar 06 00:38:56 localhost.localdomain kernel: hub 4-1:1.0: 8 ports detected
Mar 06 00:38:56 localhost.localdomain kernel: ata2: SATA link up 1.5 Gbps (=
SStatus 113 SControl 300)
Mar 06 00:38:56 localhost.localdomain kernel: ata2.00: ACPI cmd e3/00:1f:00=
:00:00:a0 (IDLE) succeeded
Mar 06 00:38:56 localhost.localdomain kernel: ata2.00: ACPI cmd e3/00:02:00=
:00:00:a0 (IDLE) succeeded
Mar 06 00:38:56 localhost.localdomain kernel: ata2.00: ATAPI: MATSHITADVD-R=
AM UJ8C0, SB01, max UDMA/133
Mar 06 00:38:56 localhost.localdomain kernel: ata2.00: ACPI cmd e3/00:1f:00=
:00:00:a0 (IDLE) succeeded
Mar 06 00:38:56 localhost.localdomain kernel: ata2.00: ACPI cmd e3/00:02:00=
:00:00:a0 (IDLE) succeeded
Mar 06 00:38:56 localhost.localdomain kernel: ata2.00: configured for UDMA/=
133
Mar 06 00:38:56 localhost.localdomain kernel: scsi 1:0:0:0: CD-ROM         =
   MATSHITA DVD-RAM UJ8C0    SB01 PQ: 0 ANSI: 5
Mar 06 00:38:56 localhost.localdomain kernel: sr 1:0:0:0: [sr0] scsi3-mmc d=
rive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Mar 06 00:38:56 localhost.localdomain kernel: cdrom: Uniform CD-ROM driver =
Revision: 3.20
Mar 06 00:38:56 localhost.localdomain kernel: sr 1:0:0:0: Attached scsi CD-=
ROM sr0
Mar 06 00:38:56 localhost.localdomain kernel: sr 1:0:0:0: Attached scsi gen=
eric sg1 type 5
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.3: new full-speed USB=
 device number 3 using ehci-pci
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.3: New USB device fou=
nd, idVendor=3D147e, idProduct=3D2020
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.3: New USB device str=
ings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.3: Product: Biometric=
 Coprocessor
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.3: Manufacturer: Auth
Mar 06 00:38:56 localhost.localdomain kernel: psmouse serio1: synaptics: To=
uchpad model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd047b3/0xb40000/0xa0000, boa=
rd id: 71, fw id: 920262
Mar 06 00:38:56 localhost.localdomain kernel: psmouse serio1: synaptics: se=
rio: Synaptics pass-through port at isa0060/serio1/input0
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.4: new full-speed USB=
 device number 4 using ehci-pci
Mar 06 00:38:56 localhost.localdomain kernel: input: SynPS/2 Synaptics Touc=
hPad as /devices/platform/i8042/serio1/input/input5
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.4: New USB device fou=
nd, idVendor=3D0a5c, idProduct=3D21e6
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.4: New USB device str=
ings: Mfr=3D1, Product=3D2, SerialNumber=3D3
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.4: Product: BCM20702A0
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.4: Manufacturer: Broa=
dcom Corp
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.4: SerialNumber: B876=
3FA7FA23
Mar 06 00:38:56 localhost.localdomain kernel: ata5: SATA link down (SStatus=
 0 SControl 300)
Mar 06 00:38:56 localhost.localdomain kernel: Freeing unused kernel memory:=
 1500K (ffffffff81d36000 - ffffffff81ead000)
Mar 06 00:38:56 localhost.localdomain kernel: Write protecting the kernel r=
ead-only data: 12288k
Mar 06 00:38:56 localhost.localdomain kernel: tsc: Refined TSC clocksource =
calibration: 2793.655 MHz
Mar 06 00:38:56 localhost.localdomain kernel: Freeing unused kernel memory:=
 588K (ffff88000176d000 - ffff880001800000)
Mar 06 00:38:56 localhost.localdomain kernel: Freeing unused kernel memory:=
 820K (ffff880001b33000 - ffff880001c00000)
Mar 06 00:38:56 localhost.localdomain kernel: random: systemd urandom read =
with 22 bits of entropy available
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.6: new high-speed USB=
 device number 5 using ehci-pci
Mar 06 00:38:56 localhost.localdomain systemd-journal[185]: Journal started
Mar 06 00:38:56 localhost.localdomain dracut-cmdline[170]: dracut-21 (Twent=
y One) dracut-038-32.git20141216.fc21
Mar 06 00:38:56 localhost.localdomain dracut-cmdline[170]: Using kernel com=
mand line parameters:
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.6: New USB device fou=
nd, idVendor=3D5986, idProduct=3D02d2
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.6: New USB device str=
ings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.6: Product: Integrate=
d Camera
Mar 06 00:38:56 localhost.localdomain kernel: usb 3-1.6: Manufacturer: Rico=
h Company Ltd.
Mar 06 00:38:56 localhost.localdomain systemd-udevd[309]: starting version =
216
Mar 06 00:38:56 localhost.localdomain kernel: pps_core: LinuxPPS API ver. 1=
 registered
Mar 06 00:38:56 localhost.localdomain kernel: pps_core: Software ver. 5.3.6=
 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Mar 06 00:38:56 localhost.localdomain kernel: PTP clock support registered
Mar 06 00:38:56 localhost.localdomain kernel: e1000e: Intel(R) PRO/1000 Net=
work Driver - 2.3.2-k
Mar 06 00:38:56 localhost.localdomain kernel: e1000e: Copyright(c) 1999 - 2=
014 Intel Corporation.
Mar 06 00:38:56 localhost.localdomain kernel: [drm] Initialized drm 1.1.0 2=
0060810
Mar 06 00:38:56 localhost.localdomain kernel: e1000e 0000:00:19.0: Interrup=
t Throttling Rate (ints/sec) set to dynamic conservative mode
Mar 06 00:38:56 localhost.localdomain kernel: e1000e 0000:00:19.0: irq 28 f=
or MSI/MSI-X
Mar 06 00:38:56 localhost.localdomain kernel: firewire_ohci 0000:02:00.3: a=
dded OHCI v1.10 device as card 0, 4 IR + 4 IT contexts, quirks 0x11
Mar 06 00:38:56 localhost.localdomain kernel: e1000e 0000:00:19.0 eth0: reg=
istered PHC clock
Mar 06 00:38:56 localhost.localdomain kernel: e1000e 0000:00:19.0 eth0: (PC=
I Express:2.5GT/s:Width x1) 3c:97:0e:c3:c6:6d
Mar 06 00:38:56 localhost.localdomain kernel: e1000e 0000:00:19.0 eth0: Int=
el(R) PRO/1000 Network Connection
Mar 06 00:38:56 localhost.localdomain kernel: e1000e 0000:00:19.0 eth0: MAC=
: 10, PHY: 11, PBA No: 1000FF-0FF
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_dump_device_info] i=
915 device info: gen=3D7, pciid=3D0x0166 rev=3D0x09 flags=3Dis_mobile,need_=
gfx_hws,is_ivybridge,has_fbc,has_hotplug,has_llc,
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_detect_pch] Found =
PantherPoint PCH
Mar 06 00:38:56 localhost.localdomain kernel: e1000e 0000:00:19.0 enp0s25: =
renamed from eth0
Mar 06 00:38:56 localhost.localdomain kernel: [drm] Memory usable by graphi=
cs device =3D 2048M
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_gtt_init] GMADR=
 size =3D 256M
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_gtt_init] GTT s=
tolen size =3D 64M
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_gtt_init] ppgtt=
 mode: 1
Mar 06 00:38:56 localhost.localdomain kernel: [drm] Replacing VGA console d=
river
Mar 06 00:38:56 localhost.localdomain kernel: Console: switching to colour =
dummy device 80x25
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_opregion_setup] gr=
aphic opregion physical addr: 0xdaf4f018
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_opregion_setup] Pu=
blic ACPI methods supported
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_opregion_setup] SW=
SCI supported
Mar 06 00:38:56 localhost.localdomain kernel: [drm:swsci_setup] SWSCI GBDA =
callbacks 00000483, SBCB callbacks 00000203
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_opregion_setup] AS=
LE supported
Mar 06 00:38:56 localhost.localdomain kernel: i915 0000:00:02.0: irq 29 for=
 MSI/MSI-X
Mar 06 00:38:56 localhost.localdomain kernel: [drm] Supports vblank timesta=
mp caching Rev 2 (21.10.2013).
Mar 06 00:38:56 localhost.localdomain kernel: [drm] Driver supports precise=
 vblank timestamp query.
Mar 06 00:38:56 localhost.localdomain kernel: [drm:init_vbt_defaults] Set d=
efault to SSC at 120000 kHz
Mar 06 00:38:56 localhost.localdomain kernel: [drm:validate_vbt] Using VBT =
from OpRegion: $VBT SNB/IVB-MOBILE d
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_general_features] =
BDB_GENERAL_FEATURES int_tv_support 0 int_crt_support 1 lvds_use_ssc 1 lvds=
_ssc_freq 120000 display_clock_mode 0 fdi_rx_polarity_inverted 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_general_definition=
s] crt_ddc_bus_pin: 2
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_lfp_panel_data] DR=
RS supported mode is static
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_lfp_panel_data] Fo=
und panel mode in BIOS VBT tables:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"1920x1080" 0 139000 1920 1980 2028 2050 1080 1090 1100 11=
30 0x8 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_lfp_panel_data] VB=
T initial LVDS value 30033c
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_lfp_backlight] VBT=
 backlight PWM modulation frequency 220 Hz, active high, min brightness 3, =
level 255
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_sdvo_panel_data] F=
ound SDVO panel mode in BIOS VBT tables:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"1600x1200" 0 162000 1600 1664 1856 2160 1200 1201 1204 12=
50 0x8 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_sdvo_device_mappin=
g] No SDVO device info is found in VBT
Mar 06 00:38:56 localhost.localdomain kernel: [drm:parse_driver_features] D=
RRS State Enabled:1
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dsm_pci_probe] no =
_DSM method for intel device
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_init_stolen] fo=
und 67108864 bytes of stolen memory at dba00000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_display_power_get]=
 enabling always-on
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Primary WM0 latency 12 (1.2 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Primary WM1 latency 4 (2.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Primary WM2 latency 16 (8.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Primary WM3 latency 32 (16.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Sprite WM0 latency 12 (1.2 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Sprite WM1 latency 4 (2.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Sprite WM2 latency 16 (8.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Sprite WM3 latency 32 (16.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Cursor WM0 latency 12 (1.2 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Cursor WM1 latency 4 (2.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Cursor WM2 latency 16 (8.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_print_wm_latency] =
Cursor WM3 latency 64 (32.0 usec)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_init] 3 di=
splay pipes available.
Mar 06 00:38:56 localhost.localdomain kernel: vgaarb: device changed decode=
s: PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_lvds_init] using p=
referred mode from EDID:=20
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 21:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 =
1130 0x48 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_lvds_init] detecte=
d dual-link lvds configuration
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_panel_setup_backli=
ght] backlight initialized, enabled, brightness 4437/4437, sysfs interface =
registered
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_crt_reset] pch crt=
 adpa set to 0xf40000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:ironlake_init_pch_refclk=
] has_panel 1 has_lvds 1 has_ck505 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:ironlake_init_pch_refclk=
] Using SSC on panel
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] [CRTC:8] hw state readout: enabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] [CRTC:12] hw state readout: disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] [CRTC:16] hw state readout: disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] PCH DPLL A hw state readout: refcount 1, on 1
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] PCH DPLL B hw state readout: refcount 0, on 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] [ENCODER:19:LVDS-19] hw state readout: enabled, pipe A
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] [ENCODER:27:DAC-27] hw state readout: disabled, pipe A
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] [CONNECTOR:18:LVDS-1] hw state readout: enabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_readout_hw=
_state] [CONNECTOR:26:VGA-1] hw state readout: disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
[CRTC:8][setup_hw_state] config for pipe A
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
cpu_transcoder: A
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pipe bpp: 18, dithering: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
fdi/pch: 1, lanes: 2, gmch_m: 4858402, gmch_n: 8388608, link_m: 269911, lin=
k_n: 524288, tu: 64
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
dp: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
dp: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
requested mode:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"" 0 0 720 0 0 0 400 0 0 0 0x0 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
adjusted mode:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_crtc_timings]=
 crtc timings: 138571 1920 1980 2028 2050 1080 1090 1100 1130, type: 0x0 fl=
ags: 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
port clock: 138571
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pipe src size: 720x400
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pch pfit: pos: 0x00000000, size: 0x07800438, enabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
ips: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
double wide: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_get_vblank_timestam=
p] crtc 1 is disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:gm45_get_vblank_counter]=
 trying to get vblank count for disabled pipe B
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_get_vblank_timestam=
p] crtc 1 is disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:gm45_get_vblank_counter]=
 trying to get vblank count for disabled pipe B
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
[CRTC:12][setup_hw_state] config for pipe B
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
cpu_transcoder: B
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pipe bpp: 0, dithering: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
fdi/pch: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
dp: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
dp: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
requested mode:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
adjusted mode:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_crtc_timings]=
 crtc timings: 0 0 0 0 0 0 0 0 0, type: 0x0 flags: 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
port clock: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pipe src size: 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pch pfit: pos: 0x00000000, size: 0x00000000, disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
ips: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
double wide: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_get_vblank_timestam=
p] crtc 2 is disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:gm45_get_vblank_counter]=
 trying to get vblank count for disabled pipe C
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_get_vblank_timestam=
p] crtc 2 is disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:gm45_get_vblank_counter]=
 trying to get vblank count for disabled pipe C
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
[CRTC:16][setup_hw_state] config for pipe C
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
cpu_transcoder: C
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pipe bpp: 0, dithering: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
fdi/pch: 0, lanes: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
dp: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
dp: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
requested mode:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
adjusted mode:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_crtc_timings]=
 crtc timings: 0 0 0 0 0 0 0 0 0, type: 0x0 flags: 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
port clock: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pipe src size: 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pch pfit: pos: 0x00000000, size: 0x00000000, disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
ips: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
double wide: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_connector_check_st=
ate] [CONNECTOR:18:LVDS-1]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:check_encoder_state] [EN=
CODER:19:LVDS-19]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:check_encoder_state] [EN=
CODER:27:DAC-27]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:check_crtc_state] [CRTC:=
8]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:check_crtc_state] [CRTC:=
12]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:check_crtc_state] [CRTC:=
16]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:check_shared_dpll_state]=
 PCH DPLL A
Mar 06 00:38:56 localhost.localdomain kernel: [drm:check_shared_dpll_state]=
 PCH DPLL B
Mar 06 00:38:56 localhost.localdomain kernel: [drm:ironlake_get_plane_confi=
g] pipe/plane 0/0 with fb: size=3D720x400@32, offset=3D0, pitch 2560, size =
0xfa000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_object_create_s=
tolen_for_preallocated] creating preallocated stolen object: stolen_offset=
=3D0, gtt_offset=3D0, size=3Dfa000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_pages_create_for_st=
olen] offset=3D0x0, size=3D1024000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_alloc_plane_obj] p=
lane fb obj ffff8807ecc58000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_setup_global_gt=
t] reserving preallocated space: 0 + fa000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_setup_global_gt=
t] clearing unused GTT space: [fa000, 7ffff000]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:gen6_ppgtt_init] Allocat=
ed pde space (2M) at GTT entry: 7fdf0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_context_init] H=
W context support initialized
Mar 06 00:38:56 localhost.localdomain kernel: [drm:init_status_page] render=
 ring hws offset: 0x7fff2000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_init_pipe_control]=
 render ring pipe control offset: 0x0011a000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:init_status_page] bsd ri=
ng hws offset: 0x0011b000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:init_status_page] blitte=
r ring hws offset: 0x0013c000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:18:LVDS-1]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_lvds_detect] [CONN=
ECTOR:18:LVDS-1]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:18:LVDS-1] probed modes :
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 21:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 =
1130 0x48 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 22:"1920x1080" 50 115830 1920 1980 2028 2050 1080 1090 1100 =
1130 0x40 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:26:VGA-1]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_crt_detect] [CONNE=
CTOR:26:VGA-1] force=3D1
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_ironlake_crt_detec=
t_hotplug] trigger hotplug detect cycle: adpa=3D0xf40000
Mar 06 00:38:56 localhost.localdomain kernel: ACPI: Video Device [VID] (mul=
ti-head: yes  rom: no  post: no)
Mar 06 00:38:56 localhost.localdomain kernel: input: Video Bus as /devices/=
LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
Mar 06 00:38:56 localhost.localdomain kernel: [drm] Initialized i915 1.6.0 =
20140905 for 0000:00:02.0 on minor 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_ironlake_crt_detec=
t_hotplug] ironlake hotplug adpa=3D0xf40000, result 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_crt_detect] CRT no=
t detected via hotplug
Mar 06 00:38:56 localhost.localdomain kernel: [drm] GMBUS [i915 gmbus vga] =
timed out, falling back to bit banging on pin 2
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_do_probe_ddc_edid] d=
rm: skipping non-existent adapter i915 gmbus vga
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_crt_detect_ddc] CR=
T not detected via DDC:0x50 [no valid EDID found]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:26:VGA-1] disconnected
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_setup_crtcs]=20
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_enable_connectors] c=
onnector 18 enabled? yes
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_enable_connectors] c=
onnector 26 enabled? no
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_fb_initial_config]=
 looking for cmdline mode on connector LVDS-1
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_fb_initial_config]=
 looking for preferred mode on connector LVDS-1
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_fb_initial_config]=
 connector LVDS-1 on pipe A [CRTC:8]: 1920x1080
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_fb_initial_config]=
 connector VGA-1 not enabled, skipping
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_setup_crtcs] desired=
 mode 1920x1080 set on crtc 8
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intelfb_create] no BIOS =
fb, allocating a new one
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_gem_object_create_s=
tolen] creating stolen object: size=3D7e9000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:i915_pages_create_for_st=
olen] offset=3D0xfa000, size=3D8294400
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intelfb_create] allocate=
d 1920x1080 fb: 0x0015e000, bo ffff8807ecce0000
Mar 06 00:38:56 localhost.localdomain kernel: fbcon: inteldrmfb (fb0) is pr=
imary device
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:8] [FB:30] #connectors=3D1 (x y) (0 0)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] modes are different, full mode set
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 29:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 =
1130 0x48 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:8], mode_changed=3D1, fb_changed=
=3D1
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_affected_p=
ipes] set mode pipe masks: modeset: 1, prepare: 1, disable: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:connected_sink_compute_b=
pp] [CONNECTOR:18:LVDS-1] checking for sink bpp constrains
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_lvds_compute_confi=
g] forcing display bpp (was 24) to LVDS (18)
Mar 06 00:38:56 localhost.localdomain kernel: [drm:ironlake_check_fdi_lanes=
] checking fdi config on pipe A, lanes 2
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_modeset_pipe_confi=
g] plane bpp: 24, pipe bpp: 18, dithering: 1
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
[CRTC:8][modeset] config for pipe A
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
cpu_transcoder: A
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pipe bpp: 18, dithering: 1
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
fdi/pch: 1, lanes: 2, gmch_m: 4858402, gmch_n: 8388608, link_m: 269911, lin=
k_n: 524288, tu: 64
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
dp: 0, gmch_m: 0, gmch_n: 0, link_m: 0, link_n: 0, tu: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
dp: 0, gmch_m2: 0, gmch_n2: 0, link_m2: 0, link_n2: 0, tu2: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
requested mode:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 1=
130 0x48 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
adjusted mode:
Mar 06 00:38:56 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 0:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 1=
130 0x48 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_crtc_timings]=
 crtc timings: 139000 1920 1980 2028 2050 1080 1090 1100 1130, type: 0x48 f=
lags: 0xa
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
port clock: 139000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pipe src size: 1920x1080
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
gmch pfit: control: 0x00000000, ratios: 0x00000000, lvds border: 0x00000000
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
pch pfit: pos: 0x00000000, size: 0x00000000, disabled
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
ips: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_dump_pipe_config] =
double wide: 0
Mar 06 00:38:56 localhost.localdomain kernel: [drm:intel_panel_actually_set=
_backlight] set backlight PWM =3D 0
Mar 06 00:38:57 localhost.localdomain kernel: firewire_core 0000:02:00.3: c=
reated device fw0: GUID 3c970effc3c66dff, S400
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_disable_shared_dpl=
l] disable PCH DPLL A (active 1, on? 1) for crtc 8
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_disable_shared_dpl=
l] disabling PCH DPLL A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_update_fbc] no out=
put, disabling
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ivb_modeset_global_resou=
rces] disabling fdi C rx
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ironlake_get_refclk] usi=
ng SSC reference clock of 120000 kHz
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_get_shared_dpll] C=
RTC:8 dropping existing PCH DPLL A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_get_shared_dpll] C=
RTC:8 allocated PCH DPLL A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_get_shared_dpll] u=
sing PCH DPLL A for pipe A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_prepare_shared_dpl=
l] setting up PCH DPLL A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ivb_manual_fdi_link_trai=
n] FDI_RX_IIR before link train 0x700
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ivb_manual_fdi_link_trai=
n] FDI_RX_IIR 0x700
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ivb_manual_fdi_link_trai=
n] FDI train 1 done, level 0.
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ivb_manual_fdi_link_trai=
n] FDI_RX_IIR 0x600
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ivb_manual_fdi_link_trai=
n] FDI train 2 done, level 0.
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ivb_manual_fdi_link_trai=
n] FDI train done.
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_enable_shared_dpll=
] enable PCH DPLL A (active 0, on? 0) for crtc 8
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_enable_shared_dpll=
] enabling PCH DPLL A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:cpt_set_fifo_underrun_re=
porting] *ERROR* uncleared pch fifo underrun on pch transcoder A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:cpt_serr_int_handler] *E=
RROR* PCH transcoder A FIFO underrun
Mar 06 00:38:57 localhost.localdomain kernel: Switched to clocksource tsc
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_panel_enable_backl=
ight] pipe A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_panel_actually_set=
_backlight] set backlight PWM =3D 4437
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ironlake_update_primary_=
plane] Writing base 0015E000 00000000 0 0 7680
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_update_fbc] disabl=
ed per chip default
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_connector_check_st=
ate] [CONNECTOR:18:LVDS-1]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:check_encoder_state] [EN=
CODER:19:LVDS-19]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:check_encoder_state] [EN=
CODER:27:DAC-27]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:check_crtc_state] [CRTC:=
8]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:check_crtc_state] [CRTC:=
12]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:check_crtc_state] [CRTC:=
16]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:check_shared_dpll_state]=
 PCH DPLL A
Mar 06 00:38:57 localhost.localdomain kernel: [drm:check_shared_dpll_state]=
 PCH DPLL B
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:12] [NOFB]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:12], mode_changed=3D0, fb_changed=
=3D0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:16] [NOFB]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:16], mode_changed=3D0, fb_changed=
=3D0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:57 localhost.localdomain kernel: Console: switching to colour =
frame buffer device 240x67
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:8] [FB:30] #connectors=3D1 (x y) (0 0)
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:8], mode_changed=3D0, fb_changed=
=3D0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:57 localhost.localdomain kernel: i915 0000:00:02.0: fb0: intel=
drmfb frame buffer device
Mar 06 00:38:57 localhost.localdomain kernel: i915 0000:00:02.0: registered=
 panic notifier
Mar 06 00:38:57 localhost.localdomain kernel: [drm:i915_gem_open]=20
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:8] [FB:30] #connectors=3D1 (x y) (0 0)
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:8], mode_changed=3D0, fb_changed=
=3D0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:12] [NOFB]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:12], mode_changed=3D0, fb_changed=
=3D0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:16] [NOFB]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:16], mode_changed=3D0, fb_changed=
=3D0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:i915_gem_open]=20
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_getresources] C=
RTC[3] CONNECTORS[2] ENCODERS[2]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_getresources] C=
RTC[3] CONNECTORS[2] ENCODERS[2]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_getconnector] [=
CONNECTOR:18:?]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:18:LVDS-1]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_lvds_detect] [CONN=
ECTOR:18:LVDS-1]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:18:LVDS-1] probed modes :
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 21:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 =
1130 0x48 0xa
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_debug_printmode=
line] Modeline 22:"1920x1080" 50 115830 1920 1980 2028 2050 1080 1090 1100 =
1130 0x40 0xa
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_getconnector] [=
CONNECTOR:18:?]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_getconnector] [=
CONNECTOR:26:?]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:26:VGA-1]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crt_detect] [CONNE=
CTOR:26:VGA-1] force=3D1
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_ironlake_crt_detec=
t_hotplug] ironlake hotplug adpa=3D0xf40000, result 0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crt_detect] CRT no=
t detected via hotplug
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_do_probe_ddc_edid] d=
rm: skipping non-existent adapter i915 gmbus vga
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crt_detect_ddc] CR=
T not detected via DDC:0x50 [no valid EDID found]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:26:VGA-1] disconnected
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_getconnector] [=
CONNECTOR:26:?]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:26:VGA-1]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crt_detect] [CONNE=
CTOR:26:VGA-1] force=3D1
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_ironlake_crt_detec=
t_hotplug] ironlake hotplug adpa=3D0xf40000, result 0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crt_detect] CRT no=
t detected via hotplug
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_do_probe_ddc_edid] d=
rm: skipping non-existent adapter i915 gmbus vga
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crt_detect_ddc] CR=
T not detected via DDC:0x50 [no valid EDID found]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_helper_probe_single_=
connector_modes_merge_bits] [CONNECTOR:26:VGA-1] disconnected
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_addfb] [FB:28]
Mar 06 00:38:57 localhost.localdomain dracut-initqueue[332]: Scanning devic=
es sda3  for LVM logical volumes fedora/root fedora/root
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_addfb] [FB:28]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_setcrtc] [CRTC:=
8]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_setcrtc] [CONNE=
CTOR:18:LVDS-1]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:8] [FB:28] #connectors=3D1 (x y) (0 0)
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:8], mode_changed=3D0, fb_changed=
=3D1
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:57 localhost.localdomain dracut-initqueue[332]: inactive '/dev=
/fedora/home' [79.03 GiB] inherit
Mar 06 00:38:57 localhost.localdomain dracut-initqueue[332]: inactive '/dev=
/fedora/root' [18.63 GiB] inherit
Mar 06 00:38:57 localhost.localdomain kernel: [drm:ironlake_update_primary_=
plane] Writing base 00947000 00000000 0 0 7680
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_setcrtc] [CRTC:=
8]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:drm_mode_setcrtc] [CONNE=
CTOR:18:LVDS-1]
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_crtc_set_config] [=
CRTC:8] [FB:28] #connectors=3D1 (x y) (0 0)
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_set_config_compute=
_mode_changes] computed changes for [CRTC:8], mode_changed=3D0, fb_changed=
=3D0
Mar 06 00:38:57 localhost.localdomain kernel: [drm:intel_modeset_stage_outp=
ut_state] [CONNECTOR:18:LVDS-1] to [CRTC:8]
Mar 06 00:38:58 localhost.localdomain systemd-fsck[435]: /dev/mapper/fedora=
-root: clean, 173526/1221600 files, 1931723/4883456 blocks
Mar 06 00:38:58 localhost.localdomain kernel: EXT4-fs (dm-0): mounted files=
ystem with ordered data mode. Opts: (null)
Mar 06 00:38:58 localhost.localdomain kernel: [drm:intel_print_rc6_info] En=
abling RC6 states: RC6 on, RC6p on, RC6pp off
Mar 06 00:38:58 localhost.localdomain kernel: [drm:gen6_enable_rps] Overclo=
cking supported. Max: 1300MHz, Overclock max: 1300MHz
Mar 06 00:38:58 localhost.localdomain systemd[1]: Switching root.
Mar 06 00:38:58 localhost.localdomain systemd-journal[185]: Journal stopped
Mar 05 23:38:58 w530 systemd-journal[532]: Runtime journal is using 8.0M (m=
ax allowed 1.5G, trying to leave 2.3G free of 15.4G available =E2=86=92 cur=
rent limit 1.5G).
Mar 05 23:38:58 w530 systemd-journal[532]: Runtime journal is using 8.0M (m=
ax allowed 1.5G, trying to leave 2.3G free of 15.4G available =E2=86=92 cur=
rent limit 1.5G).
Mar 05 23:38:58 w530 systemd-journald[185]: Received SIGTERM from PID 1 (sy=
stemd).
Mar 05 23:38:58 w530 kernel: audit: type=3D1404 audit(1425598738.384:2): en=
forcing=3D1 old_enforcing=3D0 auid=3D4294967295 ses=3D4294967295
Mar 05 23:38:58 w530 kernel: SELinux: 2048 avtab hash slots, 104708 rules.
Mar 05 23:38:58 w530 kernel: SELinux: 2048 avtab hash slots, 104708 rules.
Mar 05 23:38:58 w530 kernel: SELinux:  8 users, 103 roles, 4987 types, 295 =
bools, 1 sens, 1024 cats
Mar 05 23:38:58 w530 kernel: SELinux:  83 classes, 104708 rules
Mar 05 23:38:58 w530 kernel: SELinux:  Permission audit_read in class capab=
ility2 not defined in policy.
Mar 05 23:38:58 w530 kernel: SELinux: the above unknown classes and permiss=
ions will be allowed
Mar 05 23:38:58 w530 kernel: SELinux:  Completing initialization.
Mar 05 23:38:58 w530 kernel: SELinux:  Setting up existing superblocks.
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev rootfs, type rootfs)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev bdev, type bdev), us=
es genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev proc, type proc), us=
es genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev devtmpfs, type devtm=
pfs), uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev debugfs, type debugf=
s), uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev sockfs, type sockfs)=
, uses task SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev pipefs, type pipefs)=
, uses task SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev anon_inodefs, type a=
non_inodefs), uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev aio, type aio), not =
configured for labeling
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev devpts, type devpts)=
, uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev hugetlbfs, type huge=
tlbfs), uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev mqueue, type mqueue)=
, uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev selinuxfs, type seli=
nuxfs), uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev sysfs, type sysfs), =
uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev securityfs, type sec=
urityfs), uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev pstore, type pstore)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev cgroup, type cgroup)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev configfs, type confi=
gfs), uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev drm, type drm), not =
configured for labeling
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev dm-0, type ext4), us=
es xattr
Mar 05 23:38:58 w530 kernel: audit: type=3D1403 audit(1425598738.479:3): po=
licy loaded auid=3D4294967295 ses=3D4294967295
Mar 05 23:38:58 w530 systemd[1]: Successfully loaded SELinux policy in 106.=
256ms.
Mar 05 23:38:58 w530 systemd[1]: RTC configured in localtime, applying delt=
a of 60 minutes to system time.
Mar 05 23:38:58 w530 systemd[1]: Relabelled /dev and /run in 29.105ms.
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev autofs, type autofs)=
, uses genfs_contexts
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev hugetlbfs, type huge=
tlbfs), uses transition SIDs
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:38:58 w530 systemd-journal[532]: Journal started
Mar 05 23:38:58 w530 systemd[1]: Configuration file /usr/lib/systemd/system=
/auditd.service is marked world-inaccessible. This has no effect as configu=
ration data is accessible via APIs without restrictions. Proceeding anyway.
Mar 05 23:38:58 w530 kernel: RPC: Registered named UNIX socket transport mo=
dule.
Mar 05 23:38:58 w530 kernel: RPC: Registered udp transport module.
Mar 05 23:38:58 w530 kernel: RPC: Registered tcp transport module.
Mar 05 23:38:58 w530 kernel: RPC: Registered tcp NFSv4.1 backchannel transp=
ort module.
Mar 05 23:38:58 w530 kernel: SELinux: initialized (dev rpc_pipefs, type rpc=
_pipefs), uses genfs_contexts
Mar 05 23:38:58 w530 systemd-fsck[546]: /dev/mapper/fedora-root: Superblock=
 last write time is in the future.
Mar 05 23:38:58 w530 systemd-fsck[546]: (by less than a day, probably due t=
o the hardware clock being incorrectly set).  FIXED.
Mar 05 23:38:59 w530 lvm[536]: 1 logical volume(s) in volume group "fedora"=
 monitored
Mar 05 23:38:59 w530 kernel: random: nonblocking pool is initialized
Mar 05 23:38:59 w530 systemd-fsck[546]: /dev/mapper/fedora-root: 173526/122=
1600 files (0.2% non-contiguous), 1931723/4883456 blocks
Mar 05 23:38:59 w530 kernel: EXT4-fs (dm-0): re-mounted. Opts: (null)
Mar 05 23:38:59 w530 systemd-journal[532]: Permanent journal is using 32.0M=
 (max allowed 1.8G, trying to leave 2.7G free of 10.3G available =E2=86=92 =
current limit 1.8G).
Mar 05 23:39:00 w530 systemd-journal[532]: Time spent on flushing to /var i=
s 46.200ms for 1099 entries.
Mar 05 23:39:00 w530 kernel: Installing knfsd (copyright (C) 1996 okir@mona=
d.swb.de).
Mar 05 23:39:00 w530 kernel: SELinux: initialized (dev nfsd, type nfsd), us=
es genfs_contexts
Mar 05 23:39:00 w530 systemd-udevd[581]: starting version 216
Mar 05 23:39:00 w530 kernel: wmi: Mapper loaded
Mar 05 23:39:00 w530 kernel: tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id =
78)
Mar 05 23:39:00 w530 kernel: mei_me 0000:00:16.0: irq 30 for MSI/MSI-X
Mar 05 23:39:00 w530 kernel: [drm:intel_backlight_device_update_status] upd=
ating intel_backlight, brightness=3D2130/4437
Mar 05 23:39:00 w530 kernel: [drm:intel_panel_actually_set_backlight] set b=
acklight PWM =3D 2157
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: ThinkPad ACPI Extras v0.25
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: http://ibm-acpi.sf.net/
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: ThinkPad BIOS G5ETA1WW (2.61 ),=
 EC unknown
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: Lenovo ThinkPad W530, model 244=
150G
Mar 05 23:39:00 w530 kernel: shpchp: Standard Hot Plug PCI Controller Drive=
r version: 0.4
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: Unsupported brightness interfac=
e, please contact ibm-acpi-devel@lists.sourceforge.net
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: radio switch found; radios are =
enabled
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: This ThinkPad has standard ACPI=
 backlight brightness control, supported by the ACPI video driver
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: Disabling thinkpad-acpi brightn=
ess events by default...
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: rfkill switch tpacpi_bluetooth_=
sw: radio is unblocked
Mar 05 23:39:00 w530 kernel: thinkpad_acpi: Console audio control enabled, =
mode: monitor (read only)
Mar 05 23:39:00 w530 kernel: i801_smbus 0000:00:1f.3: SMBus using PCI Inter=
rupt
Mar 05 23:39:00 w530 mtp-probe[628]: checking bus 3, device 4: "/sys/device=
s/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.4"
Mar 05 23:39:00 w530 kernel: input: ThinkPad Extra Buttons as /devices/plat=
form/thinkpad_acpi/input/input8
Mar 05 23:39:00 w530 kernel: ACPI Warning: SystemIO range 0x000000000000042=
8-0x000000000000042f conflicts with OpRegion 0x0000000000000400-0x000000000=
000047f (\_SB_.PCI0.LPC_.PMIO) (20140926/utaddress-258)
Mar 05 23:39:00 w530 kernel: ACPI: If an ACPI driver is available for this =
device, you should use it instead of the native driver
Mar 05 23:39:00 w530 kernel: ACPI Warning: SystemIO range 0x000000000000054=
0-0x000000000000054f conflicts with OpRegion 0x0000000000000500-0x000000000=
000057f (\_SB_.PCI0.LPC_.LPIO) (20140926/utaddress-258)
Mar 05 23:39:00 w530 kernel: ACPI: If an ACPI driver is available for this =
device, you should use it instead of the native driver
Mar 05 23:39:00 w530 kernel: ACPI Warning: SystemIO range 0x000000000000053=
0-0x000000000000053f conflicts with OpRegion 0x0000000000000500-0x000000000=
000057f (\_SB_.PCI0.LPC_.LPIO) (20140926/utaddress-258)
Mar 05 23:39:00 w530 kernel: ACPI: If an ACPI driver is available for this =
device, you should use it instead of the native driver
Mar 05 23:39:00 w530 kernel: ACPI Warning: SystemIO range 0x000000000000050=
0-0x000000000000052f conflicts with OpRegion 0x0000000000000500-0x000000000=
000057f (\_SB_.PCI0.LPC_.LPIO) (20140926/utaddress-258)
Mar 05 23:39:00 w530 kernel: ACPI: If an ACPI driver is available for this =
device, you should use it instead of the native driver
Mar 05 23:39:00 w530 kernel: lpc_ich: Resource conflict(s) found affecting =
gpio_ich
Mar 05 23:39:00 w530 mtp-probe[629]: checking bus 3, device 5: "/sys/device=
s/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.6"
Mar 05 23:39:00 w530 mtp-probe[629]: bus: 3, device: 5 was not an MTP device
Mar 05 23:39:00 w530 kernel: sdhci: Secure Digital Host Controller Interfac=
e driver
Mar 05 23:39:00 w530 kernel: sdhci: Copyright(c) Pierre Ossman
Mar 05 23:39:00 w530 mtp-probe[640]: checking bus 3, device 3: "/sys/device=
s/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.3"
Mar 05 23:39:00 w530 mtp-probe[628]: bus: 3, device: 4 was not an MTP device
Mar 05 23:39:00 w530 kernel: sdhci-pci 0000:02:00.0: SDHCI controller found=
 [1180:e822] (rev 8)
Mar 05 23:39:00 w530 kernel: sdhci-pci 0000:02:00.0: No vmmc regulator found
Mar 05 23:39:00 w530 kernel: sdhci-pci 0000:02:00.0: No vqmmc regulator fou=
nd
Mar 05 23:39:00 w530 kernel: media: Linux media interface: v0.10
Mar 05 23:39:00 w530 kernel: mmc0: SDHCI controller on PCI [0000:02:00.0] u=
sing DMA
Mar 05 23:39:00 w530 kernel: tpm_tis 00:05: TPM is disabled/deactivated (0x=
6)
Mar 05 23:39:00 w530 kernel: Linux video capture interface: v2.00
Mar 05 23:39:00 w530 kernel: cfg80211: Calling CRDA to update world regulat=
ory domain
Mar 05 23:39:00 w530 kernel: snd_hda_intel 0000:00:1b.0: irq 31 for MSI/MSI=
-X
Mar 05 23:39:00 w530 kernel: alg: No test for crc32 (crc32-pclmul)
Mar 05 23:39:00 w530 kernel: Bluetooth: Core ver 2.19
Mar 05 23:39:00 w530 kernel: NET: Registered protocol family 31
Mar 05 23:39:00 w530 kernel: Bluetooth: HCI device and connection manager i=
nitialized
Mar 05 23:39:00 w530 kernel: Bluetooth: HCI socket layer initialized
Mar 05 23:39:00 w530 kernel: Bluetooth: L2CAP socket layer initialized
Mar 05 23:39:00 w530 kernel: Bluetooth: SCO socket layer initialized
Mar 05 23:39:00 w530 kernel: uvcvideo: Found UVC 1.00 device Integrated Cam=
era (5986:02d2)
Mar 05 23:39:00 w530 kernel: input: Integrated Camera as /devices/pci0000:0=
0/0000:00:1a.0/usb3/3-1/3-1.6/3-1.6:1.0/input/input9
Mar 05 23:39:00 w530 kernel: usbcore: registered new interface driver uvcvi=
deo
Mar 05 23:39:00 w530 kernel: USB Video Class driver (1.1.1)
Mar 05 23:39:00 w530 kernel: Intel(R) Wireless WiFi driver for Linux, in-tr=
ee:d
Mar 05 23:39:00 w530 kernel: Copyright(c) 2003- 2014 Intel Corporation
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: can't disable ASPM; OS d=
oesn't have ASPM control
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: irq 32 for MSI/MSI-X
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: loaded firmware version =
18.168.6.1 op_mode iwldvm
Mar 05 23:39:00 w530 mtp-probe[640]: bus: 3, device: 3 was not an MTP device
Mar 05 23:39:00 w530 kernel: sound hdaudioC0D0: autoconfig: line_outs=3D1 (=
0x14/0x0/0x0/0x0/0x0) type:speaker
Mar 05 23:39:00 w530 kernel: sound hdaudioC0D0:    speaker_outs=3D0 (0x0/0x=
0/0x0/0x0/0x0)
Mar 05 23:39:00 w530 kernel: sound hdaudioC0D0:    hp_outs=3D2 (0x15/0x1b/0=
x0/0x0/0x0)
Mar 05 23:39:00 w530 kernel: sound hdaudioC0D0:    mono: mono_out=3D0x0
Mar 05 23:39:00 w530 kernel: sound hdaudioC0D0:    inputs:
Mar 05 23:39:00 w530 kernel: sound hdaudioC0D0:      Mic=3D0x18
Mar 05 23:39:00 w530 kernel: sound hdaudioC0D0:      Dock Mic=3D0x19
Mar 05 23:39:00 w530 kernel: sound hdaudioC0D0:      Internal Mic=3D0x12
Mar 05 23:39:00 w530 kernel: input: HDA Intel PCH Mic as /devices/pci0000:0=
0/0000:00:1b.0/sound/card0/input10
Mar 05 23:39:00 w530 kernel: input: HDA Intel PCH Dock Mic as /devices/pci0=
000:00/0000:00:1b.0/sound/card0/input11
Mar 05 23:39:00 w530 kernel: input: HDA Intel PCH Headphone as /devices/pci=
0000:00/0000:00:1b.0/sound/card0/input12
Mar 05 23:39:00 w530 kernel: input: HDA Intel PCH Dock Headphone as /device=
s/pci0000:00/0000:00:1b.0/sound/card0/input13
Mar 05 23:39:00 w530 kernel: usbcore: registered new interface driver btusb
Mar 05 23:39:00 w530 kernel: bluetooth hci0: Direct firmware load for brcm/=
BCM20702A0-0a5c-21e6.hcd failed with error -2
Mar 05 23:39:00 w530 kernel: Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a=
5c-21e6.hcd not found
Mar 05 23:39:00 w530 kernel: iTCO_vendor_support: vendor-support=3D0
Mar 05 23:39:00 w530 kernel: iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
Mar 05 23:39:00 w530 kernel: iTCO_wdt: Found a Panther Point TCO device (Ve=
rsion=3D2, TCOBASE=3D0x0460)
Mar 05 23:39:00 w530 kernel: iTCO_wdt: initialized. heartbeat=3D30 sec (now=
ayout=3D0)
Mar 05 23:39:00 w530 kernel: cfg80211: World regulatory domain updated:
Mar 05 23:39:00 w530 kernel: cfg80211:  DFS Master region: unset
Mar 05 23:39:00 w530 kernel: cfg80211:   (start_freq - end_freq @ bandwidth=
), (max_antenna_gain, max_eirp), (dfs_cac_time)
Mar 05 23:39:00 w530 kernel: cfg80211:   (2402000 KHz - 2472000 KHz @ 40000=
 KHz), (N/A, 2000 mBm), (N/A)
Mar 05 23:39:00 w530 kernel: cfg80211:   (2457000 KHz - 2482000 KHz @ 40000=
 KHz), (N/A, 2000 mBm), (N/A)
Mar 05 23:39:00 w530 kernel: cfg80211:   (2474000 KHz - 2494000 KHz @ 20000=
 KHz), (N/A, 2000 mBm), (N/A)
Mar 05 23:39:00 w530 kernel: cfg80211:   (5170000 KHz - 5250000 KHz @ 80000=
 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
Mar 05 23:39:00 w530 kernel: cfg80211:   (5250000 KHz - 5330000 KHz @ 80000=
 KHz, 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
Mar 05 23:39:00 w530 kernel: cfg80211:   (5490000 KHz - 5730000 KHz @ 16000=
0 KHz), (N/A, 2000 mBm), (0 s)
Mar 05 23:39:00 w530 kernel: cfg80211:   (5735000 KHz - 5835000 KHz @ 80000=
 KHz), (N/A, 2000 mBm), (N/A)
Mar 05 23:39:00 w530 kernel: cfg80211:   (57240000 KHz - 63720000 KHz @ 216=
0000 KHz), (N/A, 0 mBm), (N/A)
Mar 05 23:39:00 w530 kernel: intel_rapl: Found RAPL domain package
Mar 05 23:39:00 w530 kernel: intel_rapl: Found RAPL domain core
Mar 05 23:39:00 w530 kernel: intel_rapl: Found RAPL domain uncore
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUG ena=
bled
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUGFS e=
nabled
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TR=
ACING disabled
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: Detected Intel(R) Centri=
no(R) Advanced-N 6205 AGN, REV=3D0xB0
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
Mar 05 23:39:00 w530 lvm[660]: 2 logical volume(s) in volume group "fedora"=
 now active
Mar 05 23:39:00 w530 systemd-fsck[707]: /dev/mapper/fedora-home: clean, 925=
/5185536 files, 382977/20716544 blocks
Mar 05 23:39:00 w530 kernel: ieee80211 phy0: Selected rate control algorith=
m 'iwl-agn-rs'
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0 wlp3s0: renamed from wlan0
Mar 05 23:39:00 w530 crda[730]: setting regulatory domain to ES based on ti=
mezone (Europe/Madrid)
Mar 05 23:39:00 w530 kernel: EXT4-fs (dm-1): mounted filesystem with ordere=
d data mode. Opts: (null)
Mar 05 23:39:00 w530 kernel: SELinux: initialized (dev dm-1, type ext4), us=
es xattr
Mar 05 23:39:00 w530 kernel: cfg80211: Calling CRDA for country: ES
Mar 05 23:39:00 w530 kernel: cfg80211: Regulatory domain changed to country=
: ES
Mar 05 23:39:00 w530 kernel: cfg80211:  DFS Master region: ETSI
Mar 05 23:39:00 w530 kernel: cfg80211:   (start_freq - end_freq @ bandwidth=
), (max_antenna_gain, max_eirp), (dfs_cac_time)
Mar 05 23:39:00 w530 kernel: cfg80211:   (2400000 KHz - 2483500 KHz @ 40000=
 KHz), (N/A, 2000 mBm), (N/A)
Mar 05 23:39:00 w530 kernel: cfg80211:   (5150000 KHz - 5250000 KHz @ 80000=
 KHz, 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
Mar 05 23:39:00 w530 kernel: cfg80211:   (5250000 KHz - 5350000 KHz @ 80000=
 KHz, 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
Mar 05 23:39:00 w530 kernel: cfg80211:   (5470000 KHz - 5725000 KHz @ 16000=
0 KHz), (N/A, 2698 mBm), (0 s)
Mar 05 23:39:00 w530 kernel: cfg80211:   (57000000 KHz - 66000000 KHz @ 216=
0000 KHz), (N/A, 4000 mBm), (N/A)
Mar 05 23:39:00 w530 auditd[747]: Started dispatcher: /sbin/audispd pid: 750
Mar 05 23:39:00 w530 audispd[750]: priority_boost_parser called with: 4
Mar 05 23:39:00 w530 audispd[750]: max_restarts_parser called with: 10
Mar 05 23:39:00 w530 audispd[750]: audispd initialized with q_depth=3D150 a=
nd 1 active plugins
Mar 05 23:39:00 w530 kernel: audit: type=3D1305 audit(1425595140.336:4): au=
dit_pid=3D747 old=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:sy=
stem_r:auditd_t:s0 res=3D1
Mar 05 23:39:00 w530 auditd[747]: Init complete, auditd 2.4.1 listening for=
 events (startup state enable)
Mar 05 23:39:00 w530 auditctl[748]: No rules
Mar 05 23:39:00 w530 alsactl[760]: alsactl 1.0.28 daemon started
Mar 05 23:39:00 w530 avahi-daemon[764]: Found user 'avahi' (UID 70) and gro=
up 'avahi' (GID 70).
Mar 05 23:39:00 w530 avahi-daemon[764]: Successfully dropped root privilege=
s.
Mar 05 23:39:00 w530 avahi-daemon[764]: avahi-daemon 0.6.31 starting up.
Mar 05 23:39:00 w530 ModemManager[770]: <info>  ModemManager (version 1.4.0=
-1.fc21) starting in system bus...
Mar 05 23:39:00 w530 netcf-transaction.sh[774]: Running  start: No pending =
transaction to rollback
Mar 05 23:39:00 w530 chronyd[791]: chronyd version 1.31 starting
Mar 05 23:39:00 w530 chronyd[791]: Frequency -1.801 +/- 2.995 ppm read from=
 /var/lib/chrony/drift
Mar 05 23:39:00 w530 avahi-daemon[764]: Successfully called chroot().
Mar 05 23:39:00 w530 avahi-daemon[764]: Successfully dropped remaining capa=
bilities.
Mar 05 23:39:00 w530 rtkit-daemon[762]: Successfully called chroot.
Mar 05 23:39:00 w530 rtkit-daemon[762]: Successfully dropped privileges.
Mar 05 23:39:00 w530 rtkit-daemon[762]: Successfully limited resources.
Mar 05 23:39:00 w530 rtkit-daemon[762]: Running.
Mar 05 23:39:00 w530 avahi-daemon[764]: No service file found in /etc/avahi=
/services.
Mar 05 23:39:00 w530 rtkit-daemon[762]: Watchdog thread running.
Mar 05 23:39:00 w530 rtkit-daemon[762]: Canary thread running.
Mar 05 23:39:00 w530 avahi-daemon[764]: Network interface enumeration compl=
eted.
Mar 05 23:39:00 w530 avahi-daemon[764]: Server startup complete. Host name =
is w530.local. Local service cookie is 3774334264.
Mar 05 23:39:00 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.systemd1'
Mar 05 23:39:00 w530 kernel: psmouse serio2: trackpoint: IBM TrackPoint fir=
mware: 0x0e, buttons: 3/3
Mar 05 23:39:00 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.PolicyKit1' unit=3D'polkit.service'
Mar 05 23:39:00 w530 systemd-logind[775]: New seat seat0.
Mar 05 23:39:00 w530 systemd-logind[775]: Watching system buttons on /dev/i=
nput/event2 (Power Button)
Mar 05 23:39:00 w530 systemd-logind[775]: Watching system buttons on /dev/i=
nput/event5 (Video Bus)
Mar 05 23:39:00 w530 systemd-logind[775]: Watching system buttons on /dev/i=
nput/event0 (Lid Switch)
Mar 05 23:39:00 w530 systemd-logind[775]: Watching system buttons on /dev/i=
nput/event1 (Sleep Button)
Mar 05 23:39:00 w530 systemd-logind[775]: Watching system buttons on /dev/i=
nput/event6 (ThinkPad Extra Buttons)
Mar 05 23:39:00 w530 polkitd[808]: Started polkitd version 0.112
Mar 05 23:39:00 w530 polkitd[808]: Loading rules from directory /etc/polkit=
-1/rules.d
Mar 05 23:39:00 w530 polkitd[808]: Loading rules from directory /usr/share/=
polkit-1/rules.d
Mar 05 23:39:00 w530 polkitd[808]: Finished loading, compiling and executin=
g 5 rules
Mar 05 23:39:00 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.PolicyKit1'
Mar 05 23:39:00 w530 polkitd[808]: Acquired the name org.freedesktop.Policy=
Kit1 on the system bus
Mar 05 23:39:00 w530 accounts-daemon[763]: started daemon version 0.6.39
Mar 05 23:39:00 w530 kernel: nf_conntrack version 0.5.0 (16384 buckets, 655=
36 max)
Mar 05 23:39:00 w530 kernel: ip6_tables: (C) 2000-2006 Netfilter Core Team
Mar 05 23:39:00 w530 kernel: Ebtables v2.0 registered
Mar 05 23:39:00 w530 kernel: bridge: automatic filtering via arp/ip/ip6tabl=
es has been deprecated. Update your scripts to load br_netfilter if you nee=
d this.
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  NetworkManager (version 0=
.9.10.1-3.20150219git.fc21) is starting...
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Read config: /etc/Network=
Manager/NetworkManager.conf and conf.d: 20-connectivity-fedora.conf
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  WEXT support is enabled
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  VPN: loaded org.freedeskt=
op.NetworkManager.openconnect
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  VPN: loaded org.freedeskt=
op.NetworkManager.pptp
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  VPN: loaded org.freedeskt=
op.NetworkManager.openvpn
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  VPN: loaded org.freedeskt=
op.NetworkManager.vpnc
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Acquired D-Bus service co=
m.redhat.ifcfgrh1
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Loaded plugin ifcfg-rh: (=
c) 2007 - 2013 Red Hat, Inc.  To report bugs please use the NetworkManager =
mailing list.
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Loaded plugin keyfile: (c=
) 2007 - 2013 Red Hat, Inc.  To report bugs please use the NetworkManager m=
ailing list.
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  parsing /etc/sysconfig/ne=
twork-scripts/ifcfg-enp0s25 ...
Mar 05 23:39:00 w530 NetworkManager[877]: <info>      read connection 'enp0=
s25'
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  parsing /etc/sysconfig/ne=
twork-scripts/ifcfg-lo ...
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  parsing /etc/sysconfig/ne=
twork-scripts/ifcfg-JAZZTEL_7SqR ...
Mar 05 23:39:00 w530 NetworkManager[877]: <info>      read connection 'JAZZ=
TEL_7SqR'
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  monitoring kernel firmwar=
e directory '/lib/firmware'.
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  rfkill2: found WiFi radio=
 killswitch (at /sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/ieee80211=
/phy0/rfkill2) (driver iwlwifi)
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  WiFi hardware radio set e=
nabled
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  WWAN hardware radio set e=
nabled
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Loaded device plugin: /us=
r/lib64/NetworkManager/libnm-device-plugin-wifi.so
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Loaded device plugin: /us=
r/lib64/NetworkManager/libnm-device-plugin-adsl.so
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Loaded device plugin: /us=
r/lib64/NetworkManager/libnm-device-plugin-bluetooth.so
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Loaded device plugin: /us=
r/lib64/NetworkManager/libnm-device-plugin-wwan.so
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  WiFi enabled by radio kil=
lswitch; enabled by state file
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  WWAN enabled by radio kil=
lswitch; enabled by state file
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  WiMAX enabled by radio ki=
llswitch; enabled by state file
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  Networking is enabled by =
state file
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (lo): link connected
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (lo): carrier is ON
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (lo): new Generic device =
(driver: 'unknown' ifindex: 1)
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (lo): exported as /org/fr=
eedesktop/NetworkManager/Devices/0
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (enp0s25): carrier is OFF
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (enp0s25): new Ethernet d=
evice (driver: 'e1000e' ifindex: 2)
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (enp0s25): exported as /o=
rg/freedesktop/NetworkManager/Devices/1
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (enp0s25): device state c=
hange: unmanaged -> unavailable (reason 'managed') [10 20 2]
Mar 05 23:39:00 w530 kernel: input: TPPS/2 IBM TrackPoint as /devices/platf=
orm/i8042/serio1/serio2/input/input6
Mar 05 23:39:00 w530 kernel: e1000e 0000:00:19.0: irq 28 for MSI/MSI-X
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (enp0s25): preparing devi=
ce
Mar 05 23:39:00 w530 kernel: e1000e 0000:00:19.0: irq 28 for MSI/MSI-X
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (wlp3s0): using nl80211 f=
or WiFi device control
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (wlp3s0): driver supports=
 Access Point (AP) mode
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (wlp3s0): new 802.11 WiFi=
 device (driver: 'iwlwifi' ifindex: 3)
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (wlp3s0): exported as /or=
g/freedesktop/NetworkManager/Devices/2
Mar 05 23:39:00 w530 NetworkManager[877]: <info>  (wlp3s0): device state ch=
ange: unmanaged -> unavailable (reason 'managed') [10 20 2]
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
Mar 05 23:39:00 w530 kernel: iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
Mar 05 23:39:01 w530 kernel: iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
Mar 05 23:39:01 w530 kernel: iwlwifi 0000:03:00.0: Radio type=3D0x1-0x2-0x0
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  (wlp3s0): preparing device
Mar 05 23:39:01 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'fi.w1.wpa_supplicant1' unit=3D'wpa_supplicant.service'
Mar 05 23:39:01 w530 systemd[1]: Configuration file /usr/lib/systemd/system=
/wpa_supplicant.service is marked executable. Please remove executable perm=
ission bits. Proceeding anyway.
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  ModemManager available in=
 the bus
Mar 05 23:39:01 w530 dbus[778]: [system] Successfully activated service 'fi=
.w1.wpa_supplicant1'
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  wpa_supplicant started
Mar 05 23:39:01 w530 bluetoothd[919]: Bluetooth daemon 5.23
Mar 05 23:39:01 w530 bluetoothd[919]: Starting SDP server
Mar 05 23:39:01 w530 kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Mar 05 23:39:01 w530 kernel: Bluetooth: BNEP filters: protocol multicast
Mar 05 23:39:01 w530 kernel: Bluetooth: BNEP socket layer initialized
Mar 05 23:39:01 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.hostname1' unit=3D'dbus-org.freedesktop.hostname1.ser=
vice'
Mar 05 23:39:01 w530 bluetoothd[919]: Bluetooth management interface 1.7 in=
itialized
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  use BlueZ version 5
Mar 05 23:39:01 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  (wlp3s0) supports 5 scan =
SSIDs
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  (wlp3s0): supplicant inte=
rface state: starting -> ready
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  (wlp3s0): device state ch=
ange: unavailable -> disconnected (reason 'supplicant-available') [20 30 42]
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  (wlp3s0): supplicant inte=
rface state: ready -> disconnected
Mar 05 23:39:01 w530 NetworkManager[877]: <info>  (wlp3s0) supports 5 scan =
SSIDs
Mar 05 23:39:01 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.hostname1'
Mar 05 23:39:02 w530 ModemManager[770]: <warn>  Couldn't find support for d=
evice at '/sys/devices/pci0000:00/0000:00:19.0': not supported by any plugin
Mar 05 23:39:02 w530 ModemManager[770]: <warn>  Couldn't find support for d=
evice at '/sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0': not supported=
 by any plugin
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  (wlp3s0): supplicant inte=
rface state: disconnected -> inactive
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Auto-activating connectio=
n 'JAZZTEL_7SqR'.
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Activation (wlp3s0) start=
ing connection 'JAZZTEL_7SqR'
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 1 of 5 (Device Prepare) scheduled...
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 1 of 5 (Device Prepare) started...
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  (wlp3s0): device state ch=
ange: disconnected -> prepare (reason 'none') [30 40 0]
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  NetworkManager state is n=
ow CONNECTING
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 2 of 5 (Device Configure) scheduled...
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 1 of 5 (Device Prepare) complete.
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 2 of 5 (Device Configure) starting...
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  (wlp3s0): device state ch=
ange: prepare -> config (reason 'none') [40 50 0]
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Activation (wlp3s0/wirele=
ss): connection 'JAZZTEL_7SqR' has security, and secrets exist.  No new sec=
rets needed.
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Config: added 'ssid' valu=
e 'JAZZTEL_7SqR'
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Config: added 'scan_ssid'=
 value '1'
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Config: added 'key_mgmt' =
value 'WPA-PSK'
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Config: added 'psk' value=
 '<omitted>'
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Config: added 'proto' val=
ue 'WPA RSN'
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 2 of 5 (Device Configure) complete.
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  Config: set interface ap_=
scan to 1
Mar 05 23:39:03 w530 NetworkManager[877]: <info>  (wlp3s0): supplicant inte=
rface state: inactive -> scanning
Mar 05 23:39:06 w530 kernel: wlp3s0: authenticate with 2c:95:7f:40:b1:60
Mar 05 23:39:06 w530 kernel: wlp3s0: send auth to 2c:95:7f:40:b1:60 (try 1/=
3)
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  (wlp3s0): supplicant inte=
rface state: scanning -> authenticating
Mar 05 23:39:06 w530 kernel: wlp3s0: authenticated
Mar 05 23:39:06 w530 kernel: wlp3s0: associate with 2c:95:7f:40:b1:60 (try =
1/3)
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  (wlp3s0): supplicant inte=
rface state: authenticating -> associating
Mar 05 23:39:06 w530 kernel: wlp3s0: RX AssocResp from 2c:95:7f:40:b1:60 (c=
apab=3D0x411 status=3D0 aid=3D3)
Mar 05 23:39:06 w530 kernel: wlp3s0: associated
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  (wlp3s0): supplicant inte=
rface state: associating -> 4-way handshake
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  (wlp3s0): supplicant inte=
rface state: 4-way handshake -> completed
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  Activation (wlp3s0/wirele=
ss) Stage 2 of 5 (Device Configure) successful.  Connected to wireless netw=
ork 'JAZZTEL_7SqR'.
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 3 of 5 (IP Configure Start) scheduled.
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 3 of 5 (IP Configure Start) started...
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  (wlp3s0): device state ch=
ange: config -> ip-config (reason 'none') [50 70 0]
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Begin=
ning DHCPv4 transaction (timeout in 45 seconds)
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  dhclient started with pid=
 1234
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 3 of 5 (IP Configure Start) complete.
Mar 05 23:39:06 w530 NetworkManager[877]: <info>  (wlp3s0): DHCPv4 state ch=
anged nbi -> preinit
Mar 05 23:39:06 w530 dhclient[1234]: DHCPREQUEST on wlp3s0 to 255.255.255.2=
55 port 67 (xid=3D0x2834fc31)
Mar 05 23:39:08 w530 avahi-daemon[764]: Registering new address record for =
fe80::6e88:14ff:fe31:fb88 on wlp3s0.*.
Mar 05 23:39:10 w530 dhclient[1234]: DHCPREQUEST on wlp3s0 to 255.255.255.2=
55 port 67 (xid=3D0x2834fc31)
Mar 05 23:39:10 w530 dhclient[1234]: DHCPACK from 192.168.1.1 (xid=3D0x2834=
fc31)
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  (wlp3s0): DHCPv4 state ch=
anged preinit -> reboot
Mar 05 23:39:10 w530 NetworkManager[877]: <info>    address 192.168.1.131
Mar 05 23:39:10 w530 NetworkManager[877]: <info>    plen 24 (255.255.255.0)
Mar 05 23:39:10 w530 NetworkManager[877]: <info>    gateway 192.168.1.1
Mar 05 23:39:10 w530 NetworkManager[877]: <info>    server identifier 192.1=
68.1.1
Mar 05 23:39:10 w530 NetworkManager[877]: <info>    lease time 259200
Mar 05 23:39:10 w530 NetworkManager[877]: <info>    nameserver '87.216.1.65'
Mar 05 23:39:10 w530 NetworkManager[877]: <info>    nameserver '87.216.1.66'
Mar 05 23:39:10 w530 NetworkManager[877]: <info>    domain name 'Home'
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 5 of 5 (IPv4 Configure Commit) scheduled...
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 5 of 5 (IPv4 Commit) started...
Mar 05 23:39:10 w530 avahi-daemon[764]: Joining mDNS multicast group on int=
erface wlp3s0.IPv4 with address 192.168.1.131.
Mar 05 23:39:10 w530 avahi-daemon[764]: New relevant interface wlp3s0.IPv4 =
for mDNS.
Mar 05 23:39:10 w530 avahi-daemon[764]: Registering new address record for =
192.168.1.131 on wlp3s0.IPv4.
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  (wlp3s0): device state ch=
ange: ip-config -> ip-check (reason 'none') [70 80 0]
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 5 of 5 (IPv4 Commit) complete.
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  (wlp3s0): device state ch=
ange: ip-check -> secondaries (reason 'none') [80 90 0]
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  (wlp3s0): device state ch=
ange: secondaries -> activated (reason 'none') [90 100 0]
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  NetworkManager state is n=
ow CONNECTED_LOCAL
Mar 05 23:39:10 w530 dhclient[1234]: bound to 192.168.1.131 -- renewal in 1=
22888 seconds.
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  NetworkManager state is n=
ow CONNECTED_SITE
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  Policy set 'JAZZTEL_7SqR'=
 (wlp3s0) as default for IPv4 routing and DNS.
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  Activation (wlp3s0) succe=
ssful, device activated.
Mar 05 23:39:10 w530 NetworkManager[877]: <info>  startup complete
Mar 05 23:39:10 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.nm_dispatcher' unit=3D'dbus-org.freedesktop.nm-dispat=
cher.service'
Mar 05 23:39:10 w530 sm-notify[1241]: Version 1.3.1 starting
Mar 05 23:39:11 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.nm_dispatcher'
Mar 05 23:39:11 w530 sshd[1239]: Server listening on 0.0.0.0 port 22.
Mar 05 23:39:11 w530 nm-dispatcher[1242]: Dispatching action 'up' for wlp3s0
Mar 05 23:39:11 w530 sshd[1239]: Server listening on :: port 22.
Mar 05 23:39:11 w530 crond[1252]: (CRON) INFO (Syslog will be used instead =
of sendmail.)
Mar 05 23:39:11 w530 crond[1252]: (CRON) INFO (RANDOM_DELAY will be scaled =
with factor 3% if used.)
Mar 05 23:39:11 w530 systemd[1]: Unit iscsi.service cannot be reloaded beca=
use it is inactive.
Mar 05 23:39:11 w530 libvirtd[1240]: libvirt version: 1.2.9.2, package: 1.f=
c21 (Fedora Project, 2015-02-08-03:13:36, buildvm-09.phx2.fedoraproject.org)
Mar 05 23:39:11 w530 libvirtd[1240]: Module /usr/lib64/libvirt/connection-d=
river/libvirt_driver_vbox_network.so not accessible
Mar 05 23:39:11 w530 libvirtd[1240]: Module /usr/lib64/libvirt/connection-d=
river/libvirt_driver_vbox_storage.so not accessible
Mar 05 23:39:11 w530 libvirtd[1240]: Module /usr/lib64/libvirt/connection-d=
river/libvirt_driver_xen.so not accessible
Mar 05 23:39:11 w530 libvirtd[1240]: Module /usr/lib64/libvirt/connection-d=
river/libvirt_driver_libxl.so not accessible
Mar 05 23:39:11 w530 libvirtd[1240]: Module /usr/lib64/libvirt/connection-d=
river/libvirt_driver_lxc.so not accessible
Mar 05 23:39:11 w530 libvirtd[1240]: Module /usr/lib64/libvirt/connection-d=
river/libvirt_driver_uml.so not accessible
Mar 05 23:39:11 w530 libvirtd[1240]: Module /usr/lib64/libvirt/connection-d=
river/libvirt_driver_vbox.so not accessible
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: X.Org X Server 1.16.3
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Release Date: 2014-12-20
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: X Protocol Version 11, Revision 0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Build Operating System:  3.17.8-300=
.bz1178975.fc21.x86_64
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Current Operating System: Linux w53=
0 3.18.7-200.fc21.x86_64 #1 SMP Wed Feb 11 21:53:17 UTC 2015 x86_64
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Kernel command line: BOOT_IMAGE=3D/=
boot/vmlinuz-3.18.7-200.fc21.x86_64 root=3D/dev/mapper/fedora-root ro rd.lv=
m.lv=3Dfedora/root rhgb quiet LANG=3Den_DK.UTF-8 crashkernel=3D128M drm.deb=
ug=3D14 log_buf_len=3D16M
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Build Date: 31 January 2015  11:23:=
27PM
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Build ID: xorg-x11-server 1.16.3-2.=
fc21
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Current version of pixman: 0.32.6
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Before reporting problems, check ht=
tp://wiki.x.org
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: to make sure that you have the late=
st version.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Markers: (--) probed, (**) from con=
fig file, (=3D=3D) default setting,
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (++) from command line, (!!) notice=
, (II) informational,
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (WW) warning, (EE) error, (NI) not =
implemented, (??) unknown.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (++) Log file: "/dev/null", Time: T=
hu Mar  5 23:39:11 2015
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Using config directory: "/=
etc/X11/xorg.conf.d"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Using system config direct=
ory "/usr/share/X11/xorg.conf.d"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) No Layout section.  Using =
the first Screen section.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) No screen section availabl=
e. Using defaults.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) |-->Screen "Default Screen Sec=
tion" (0)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) |   |-->Monitor "<default moni=
tor>"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) No monitor specified for s=
creen "Default Screen Section".
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Using a default monitor configurati=
on.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Automatically adding devic=
es
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Automatically enabling dev=
ices
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Automatically adding GPU d=
evices
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) FontPath set to:
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: catalogue:/etc/X11/fontpath.d,
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: built-ins
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) ModulePath set to "/usr/li=
b64/xorg/modules"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) The server relies on udev to p=
rovide the list of input devices.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: If no devices become available, rec=
onfigure udev or disable AutoAddDevices.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loader magic: 0x81de40
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module ABI versions:
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: X.Org ANSI C Emulation: 0.4
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: X.Org Video Driver: 18.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: X.Org XInput driver : 21.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: X.Org Server Extension : 8.0
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (EE) systemd-logind: failed to get =
session: PID 1293 does not belong to any known session
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) xfree86: Adding drm device (/d=
ev/dri/card0)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) PCI:*(0:0:2:0) 8086:0166:17aa:=
21f5 rev 9, Mem @ 0xf0000000/4194304, 0xe0000000/268435456, I/O @ 0x0000500=
0/64, BIOS @ 0x????????/131072
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "glx"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading /usr/lib64/xorg/module=
s/extensions/libglx.so
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module glx: vendor=3D"X.Org Fo=
undation"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: compiled for 1.16.3, module version=
 =3D 1.0.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: ABI class: X.Org Server Extension, =
version 8.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) AIGLX enabled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Matched intel as autoconfi=
gured driver 0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Matched intel as autoconfi=
gured driver 1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Matched modesetting as aut=
oconfigured driver 2
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Matched fbdev as autoconfi=
gured driver 3
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Matched vesa as autoconfig=
ured driver 4
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Assigned the driver to the=
 xf86ConfigLayout
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "intel"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading /usr/lib64/xorg/module=
s/drivers/intel_drv.so
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module intel: vendor=3D"X.Org =
Foundation"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: compiled for 1.16.1, module version=
 =3D 2.99.916
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Module class: X.Org Video Driver
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: ABI class: X.Org Video Driver, vers=
ion 18.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "modesetting"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading /usr/lib64/xorg/module=
s/drivers/modesetting_drv.so
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module modesetting: vendor=3D"=
X.Org Foundation"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: compiled for 1.16.0, module version=
 =3D 0.9.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Module class: X.Org Video Driver
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: ABI class: X.Org Video Driver, vers=
ion 18.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "fbdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading /usr/lib64/xorg/module=
s/drivers/fbdev_drv.so
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module fbdev: vendor=3D"X.Org =
Foundation"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: compiled for 1.16.0, module version=
 =3D 0.4.3
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Module class: X.Org Video Driver
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: ABI class: X.Org Video Driver, vers=
ion 18.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "vesa"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading /usr/lib64/xorg/module=
s/drivers/vesa_drv.so
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module vesa: vendor=3D"X.Org F=
oundation"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: compiled for 1.16.0, module version=
 =3D 2.3.2
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Module class: X.Org Video Driver
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: ABI class: X.Org Video Driver, vers=
ion 18.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel: Driver for Intel(R) Int=
egrated Graphics Chipsets:
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: i810, i810-dc100, i810e, i815, i830=
M, 845G, 854, 852GM/855GM, 865G,
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: 915G, E7221 (i915), 915GM, 945G, 94=
5GM, 945GME, Pineview GM,
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Pineview G, 965G, G35, 965Q, 946GZ,=
 965GM, 965GME/GLE, G33, Q35, Q33,
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: GM45, 4 Series, G45/G43, Q45/Q43, G=
41, B43
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel: Driver for Intel(R) HD =
Graphics: 2000-6000
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel: Driver for Intel(R) Iri=
s(TM) Graphics: 5100, 6100
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel: Driver for Intel(R) Iri=
s(TM) Pro Graphics: 5200, 6200, P6300
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) modesetting: Driver for Modese=
tting Kernel Drivers: kms
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) FBDEV: driver for framebuffer:=
 fbdev
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) VESA: driver for VESA chipsets=
: vesa
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (++) using VT number 1
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getresources] CRTC[3] CONNECTORS=
[2] ENCODERS[2]
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getresources] CRTC[3] CONNECTORS=
[2] ENCODERS[2]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getresources] CRTC[3] CONNECTORS=
[2] ENCODERS[2]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getresources] CRTC[3] CONNECTORS=
[2] ENCODERS[2]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_addfb] [FB:31]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getresources] CRTC[3] CONNECTORS=
[2] ENCODERS[2]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getresources] CRTC[3] CONNECTORS=
[2] ENCODERS[2]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:26:?]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:26:?]
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Using Kernel Mode Se=
tting driver: i915, version 1.6.0 20140905
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (WW) Falling back to old probe meth=
od for modesetting
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (WW) Falling back to old probe meth=
od for fbdev
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading sub module "fbdevhw"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "fbdevhw"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading /usr/lib64/xorg/module=
s/libfbdevhw.so
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module fbdevhw: vendor=3D"X.Or=
g Foundation"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: compiled for 1.16.3, module version=
 =3D 0.0.2
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: ABI class: X.Org Video Driver, vers=
ion 18.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (WW) Falling back to old probe meth=
od for vesa
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) intel(0): Integrated Graphics =
Chipset: Intel(R) HD Graphics 4000
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) intel(0): CPU: x86-64, sse2, s=
se3, ssse3, sse4.1, sse4.2, avx
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Creating default Dis=
play subsection in Screen section
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: "Default Screen Section" for depth/=
fbbpp 24/32
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): Depth 24, (--) f=
ramebuffer bpp 32
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): RGB weight 888
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): Default visual i=
s TrueColor
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Output LVDS1 has no =
monitor section
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) intel(0): Found backlight cont=
rol interface intel_backlight (type 'raw') for output LVDS1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Enabled output LVDS1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Output VGA1 has no m=
onitor section
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Enabled output VGA1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) intel(0): Using a maximum size=
 of 256x256 for hardware cursors
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Output VIRTUAL1 has =
no monitor section
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Enabled output VIRTU=
AL1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) intel(0): Output LVDS1 using i=
nitial mode 1920x1080 on pipe 0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): TearFree disabled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): DPI set to (96, =
96)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading sub module "dri3"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "dri3"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module "dri3" already built-in
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading sub module "dri2"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "dri2"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module "dri2" already built-in
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading sub module "present"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "present"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module "present" already built=
-in
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) UnloadModule: "modesetting"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Unloading modesetting
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) UnloadModule: "fbdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Unloading fbdev
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) UnloadSubModule: "fbdevhw"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Unloading fbdevhw
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) UnloadModule: "vesa"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Unloading vesa
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) Depth 24 pixmap format is =
32 bpp
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): SNA initialized with=
 Ivybridge (gen7, gt2) backend
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): Backing store en=
abled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): Silken mouse ena=
bled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): HW Cursor enabled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): RandR 1.2 enabled, i=
gnore the following RandR disabled message.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): DPMS enabled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (=3D=3D) intel(0): display hotplug =
detection enabled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): [DRI2] Setup complete
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): [DRI2]   DRI driver:=
 i965
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): [DRI2]   VDPAU drive=
r: i965
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): direct rendering: DR=
I2 DRI3 enabled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): hardware support for=
 Present enabled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) RandR disabled
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) SELinux: Disabled by boolean
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): carrier is OFF
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): new Bridge devi=
ce (driver: 'bridge' ifindex: 4)
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): exported as /or=
g/freedesktop/NetworkManager/Devices/3
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): device state ch=
ange: unmanaged -> unavailable (reason 'managed') [10 20 2]
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): preparing device
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): device state ch=
ange: unavailable -> disconnected (reason 'none') [20 30 0]
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_MESA_copy_s=
ub_buffer
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_ARB_create_=
context
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_ARB_create_=
context_profile
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_EXT_create_=
context_es2_profile
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_INTEL_swap_=
event
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_SGI_swap_co=
ntrol and GLX_MESA_swap_control
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_EXT_framebu=
ffer_sRGB
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_ARB_fbconfi=
g_float
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: GLX_EXT_texture_from_pi=
xmap backed by buffer objects
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: enabled GLX_ARB_create_=
context_robustness
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) AIGLX: Loaded and initialized =
i965
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) GLX: Initialized DRI2 GL provi=
der for screen 0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): switch to mode 1920x=
1080@60.0 on LVDS1 using pipe 0, position (0, 0), rotation normal, reflecti=
on none
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_addfb] [FB:31]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_setcrtc] [CRTC:8]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_setcrtc] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:11 w530 kernel: [drm:intel_crtc_set_config] [CRTC:8] [FB:31] #=
connectors=3D1 (x y) (0 0)
Mar 05 23:39:11 w530 kernel: [drm:intel_set_config_compute_mode_changes] co=
mputed changes for [CRTC:8], mode_changed=3D0, fb_changed=3D1
Mar 05 23:39:11 w530 kernel: [drm:intel_modeset_stage_output_state] [CONNEC=
TOR:18:LVDS-1] to [CRTC:8]
Mar 05 23:39:11 w530 kernel: [drm:ironlake_update_primary_plane] Writing ba=
se 01130000 00000000 0 0 7680
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Setting screen physi=
cal size to 508 x 285
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_setcrtc] [CRTC:12]
Mar 05 23:39:11 w530 kernel: [drm:intel_crtc_set_config] [CRTC:12] [NOFB]
Mar 05 23:39:11 w530 kernel: [drm:intel_set_config_compute_mode_changes] co=
mputed changes for [CRTC:12], mode_changed=3D0, fb_changed=3D0
Mar 05 23:39:11 w530 kernel: [drm:intel_modeset_stage_output_state] [CONNEC=
TOR:18:LVDS-1] to [CRTC:8]
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_setcrtc] [CRTC:16]
Mar 05 23:39:11 w530 kernel: [drm:intel_crtc_set_config] [CRTC:16] [NOFB]
Mar 05 23:39:11 w530 kernel: [drm:intel_set_config_compute_mode_changes] co=
mputed changes for [CRTC:16], mode_changed=3D0, fb_changed=3D0
Mar 05 23:39:11 w530 kernel: [drm:intel_modeset_stage_output_state] [CONNEC=
TOR:18:LVDS-1] to [CRTC:8]
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce Power Button (/dev/input/event2)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Power Button: Applying InputCl=
ass "evdev keyboard catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Power Button: Applying InputCl=
ass "system-keyboard"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "evdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading /usr/lib64/xorg/module=
s/input/evdev_drv.so
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module evdev: vendor=3D"X.Org =
Foundation"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: compiled for 1.16.0, module version=
 =3D 2.9.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Module class: X.Org XInput Driver
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: ABI class: X.Org XInput driver, ver=
sion 21.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Using input driver 'evdev' for=
 'Power Button'
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Power Button: always reports c=
ore events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: Power Button: Device: "=
/dev/input/event2"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: Power Button: Vendor 0 =
Product 0x1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: Power Button: Found keys
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) evdev: Power Button: Configuri=
ng as keyboard
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "config_info" "udev:/sy=
s/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2/event2"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) XINPUT: Adding extended input =
device "Power Button" (type: KEYBOARD, id 6)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_rules" "evdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_model" "pc104"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_layout" "dk"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: The XKEYBOARD keymap compiler (xkbc=
omp) reports:
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: > Warning:          Type "ONE_LEVEL=
" has 1 levels, but <RALT> has 2 symbols
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: >                   Ignoring extra =
symbols
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Errors from xkbcomp are not fatal t=
o the X server
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce Video Bus (/dev/input/event5)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Video Bus: Applying InputClass=
 "evdev keyboard catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Video Bus: Applying InputClass=
 "system-keyboard"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Using input driver 'evdev' for=
 'Video Bus'
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Video Bus: always reports core=
 events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: Video Bus: Device: "/de=
v/input/event5"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: Video Bus: Vendor 0 Pro=
duct 0x6
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: Video Bus: Found keys
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) evdev: Video Bus: Configuring =
as keyboard
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "config_info" "udev:/sy=
s/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7/event=
5"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) XINPUT: Adding extended input =
device "Video Bus" (type: KEYBOARD, id 7)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_rules" "evdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_model" "pc104"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_layout" "dk"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce Lid Switch (/dev/input/event0)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) No input driver specified, ign=
oring this device.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) This device may have been adde=
d with another device file.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce Sleep Button (/dev/input/event1)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Sleep Button: Applying InputCl=
ass "evdev keyboard catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Sleep Button: Applying InputCl=
ass "system-keyboard"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Using input driver 'evdev' for=
 'Sleep Button'
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Sleep Button: always reports c=
ore events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: Sleep Button: Device: "=
/dev/input/event1"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: Sleep Button: Vendor 0 =
Product 0x3
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: Sleep Button: Found keys
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) evdev: Sleep Button: Configuri=
ng as keyboard
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "config_info" "udev:/sy=
s/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1/event1"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) XINPUT: Adding extended input =
device "Sleep Button" (type: KEYBOARD, id 8)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_rules" "evdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_model" "pc104"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_layout" "dk"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce Integrated Camera (/dev/input/event7)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Integrated Camera: Applying In=
putClass "evdev keyboard catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Integrated Camera: Applying In=
putClass "system-keyboard"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Using input driver 'evdev' for=
 'Integrated Camera'
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Integrated Camera: always repo=
rts core events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: Integrated Camera: Devi=
ce: "/dev/input/event7"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: Integrated Camera: Vend=
or 0x5986 Product 0x2d2
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: Integrated Camera: Foun=
d keys
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) evdev: Integrated Camera: Conf=
iguring as keyboard
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "config_info" "udev:/sy=
s/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.6/3-1.6:1.0/input/input9/eve=
nt7"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) XINPUT: Adding extended input =
device "Integrated Camera" (type: KEYBOARD, id 9)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_rules" "evdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_model" "pc104"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_layout" "dk"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce HDA Intel PCH Mic (/dev/input/event8)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) No input driver specified, ign=
oring this device.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) This device may have been adde=
d with another device file.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce HDA Intel PCH Dock Mic (/dev/input/event9)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) No input driver specified, ign=
oring this device.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) This device may have been adde=
d with another device file.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce HDA Intel PCH Headphone (/dev/input/event10)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) No input driver specified, ign=
oring this device.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) This device may have been adde=
d with another device file.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce HDA Intel PCH Dock Headphone (/dev/input/event11)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) No input driver specified, ign=
oring this device.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) This device may have been adde=
d with another device file.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce AT Translated Set 2 keyboard (/dev/input/event3)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) AT Translated Set 2 keyboard: =
Applying InputClass "evdev keyboard catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) AT Translated Set 2 keyboard: =
Applying InputClass "system-keyboard"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Using input driver 'evdev' for=
 'AT Translated Set 2 keyboard'
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) AT Translated Set 2 keyboard: =
always reports core events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: AT Translated Set 2 key=
board: Device: "/dev/input/event3"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: AT Translated Set 2 key=
board: Vendor 0x1 Product 0x1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: AT Translated Set 2 key=
board: Found keys
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) evdev: AT Translated Set 2 key=
board: Configuring as keyboard
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "config_info" "udev:/sy=
s/devices/platform/i8042/serio0/input/input3/event3"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) XINPUT: Adding extended input =
device "AT Translated Set 2 keyboard" (type: KEYBOARD, id 10)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_rules" "evdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_model" "pc104"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_layout" "dk"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce SynPS/2 Synaptics TouchPad (/dev/input/event4)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: Ap=
plying InputClass "evdev touchpad catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: Ap=
plying InputClass "touchpad catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: Ap=
plying InputClass "Default clickpad buttons"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) LoadModule: "synaptics"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Loading /usr/lib64/xorg/module=
s/input/synaptics_drv.so
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Module synaptics: vendor=3D"X.=
Org Foundation"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: compiled for 1.16.3, module version=
 =3D 1.8.1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: Module class: X.Org XInput Driver
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: ABI class: X.Org XInput driver, ver=
sion 21.0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Using input driver 'synaptics'=
 for 'SynPS/2 Synaptics TouchPad'
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: al=
ways reports core events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "Device" "/dev/input/ev=
ent4"
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  NetworkManager state is n=
ow CONNECTED_GLOBAL
Mar 05 23:39:11 w530 crond[1252]: (CRON) INFO (running with inotify support)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) synaptics: SynPS/2 Synaptics T=
ouchPad: ignoring touch events for semi-multitouch device
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) synaptics: SynPS/2 Synaptics T=
ouchPad: x-axis range 1472 - 5470 (res 60)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) synaptics: SynPS/2 Synaptics T=
ouchPad: y-axis range 1408 - 4498 (res 85)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) synaptics: SynPS/2 Synaptics T=
ouchPad: pressure range 0 - 255
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) synaptics: SynPS/2 Synaptics T=
ouchPad: finger width range 0 - 15
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) synaptics: SynPS/2 Synaptics T=
ouchPad: buttons: left right double triple
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) synaptics: SynPS/2 Synaptics T=
ouchPad: Vendor 0x2 Product 0x7
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) synaptics: SynPS/2 Synaptics T=
ouchPad: touchpad found
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: al=
ways reports core events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "config_info" "udev:/sy=
s/devices/platform/i8042/serio1/input/input5/event4"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) XINPUT: Adding extended input =
device "SynPS/2 Synaptics TouchPad" (type: TOUCHPAD, id 11)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) synaptics: SynPS/2 Synaptics T=
ouchPad: (accel) MinSpeed is now constant deceleration 2.5
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) synaptics: SynPS/2 Synaptics T=
ouchPad: (accel) MaxSpeed is now 1.75
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) synaptics: SynPS/2 Synaptics T=
ouchPad: (accel) AccelFactor is now 0.040
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: (a=
ccel) keeping acceleration scheme 1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: (a=
ccel) acceleration profile 1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: (a=
ccel) acceleration factor: 2.000
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) SynPS/2 Synaptics TouchPad: (a=
ccel) acceleration threshold: 4
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) synaptics: SynPS/2 Synaptics T=
ouchPad: touchpad found
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce SynPS/2 Synaptics TouchPad (/dev/input/mouse0)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) No input driver specified, ign=
oring this device.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) This device may have been adde=
d with another device file.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce TPPS/2 IBM TrackPoint (/dev/input/event12)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) TPPS/2 IBM TrackPoint: Applyin=
g InputClass "evdev pointer catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Using input driver 'evdev' for=
 'TPPS/2 IBM TrackPoint'
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) TPPS/2 IBM TrackPoint: always =
reports core events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: TPPS/2 IBM TrackPoint: =
Device: "/dev/input/event12"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: TPPS/2 IBM TrackPoint: =
Vendor 0x2 Product 0xa
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: TPPS/2 IBM TrackPoint: =
Found 3 mouse buttons
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: TPPS/2 IBM TrackPoint: =
Found relative axes
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: TPPS/2 IBM TrackPoint: =
Found x and y relative axes
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) evdev: TPPS/2 IBM TrackPoint: =
Configuring as mouse
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: TPPS/2 IBM TrackPoint: =
YAxisMapping: buttons 4 and 5
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: TPPS/2 IBM TrackPoint: =
EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "config_info" "udev:/sy=
s/devices/platform/i8042/serio1/serio2/input/input6/event12"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) XINPUT: Adding extended input =
device "TPPS/2 IBM TrackPoint" (type: MOUSE, id 12)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) evdev: TPPS/2 IBM TrackPoint: =
initialized for relative axes.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) TPPS/2 IBM TrackPoint: (accel)=
 keeping acceleration scheme 1
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) TPPS/2 IBM TrackPoint: (accel)=
 acceleration profile 0
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) TPPS/2 IBM TrackPoint: (accel)=
 acceleration factor: 2.000
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) TPPS/2 IBM TrackPoint: (accel)=
 acceleration threshold: 4
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce TPPS/2 IBM TrackPoint (/dev/input/mouse1)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) No input driver specified, ign=
oring this device.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) This device may have been adde=
d with another device file.
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) config/udev: Adding input devi=
ce ThinkPad Extra Buttons (/dev/input/event6)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) ThinkPad Extra Buttons: Applyi=
ng InputClass "evdev keyboard catchall"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) ThinkPad Extra Buttons: Applyi=
ng InputClass "system-keyboard"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) Using input driver 'evdev' for=
 'ThinkPad Extra Buttons'
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) ThinkPad Extra Buttons: always=
 reports core events
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) evdev: ThinkPad Extra Buttons:=
 Device: "/dev/input/event6"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: ThinkPad Extra Buttons:=
 Vendor 0x17aa Product 0x5054
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (--) evdev: ThinkPad Extra Buttons:=
 Found keys
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) evdev: ThinkPad Extra Buttons:=
 Configuring as keyboard
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "config_info" "udev:/sy=
s/devices/platform/thinkpad_acpi/input/input8/event6"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) XINPUT: Adding extended input =
device "ThinkPad Extra Buttons" (type: KEYBOARD, id 13)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_rules" "evdev"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_model" "pc104"
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (**) Option "xkb_layout" "dk"
Mar 05 23:39:11 w530 avahi-daemon[764]: Joining mDNS multicast group on int=
erface virbr0.IPv4 with address 192.168.122.1.
Mar 05 23:39:11 w530 avahi-daemon[764]: New relevant interface virbr0.IPv4 =
for mDNS.
Mar 05 23:39:11 w530 avahi-daemon[764]: Registering new address record for =
192.168.122.1 on virbr0.IPv4.
Mar 05 23:39:11 w530 NetworkManager[877]: <info>      read connection 'virb=
r0'
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) start=
ing connection 'virbr0'
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 1 of 5 (Device Prepare) scheduled...
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 1 of 5 (Device Prepare) started...
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): device state ch=
ange: disconnected -> prepare (reason 'none') [30 40 0]
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 2 of 5 (Device Configure) scheduled...
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 1 of 5 (Device Prepare) complete.
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 2 of 5 (Device Configure) starting...
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): device state ch=
ange: prepare -> config (reason 'none') [40 50 0]
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 2 of 5 (Device Configure) successful.
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 2 of 5 (Device Configure) complete.
Mar 05 23:39:11 w530 dnsmasq[1350]: started, version 2.72 cachesize 150
Mar 05 23:39:11 w530 dnsmasq[1350]: compile time options: IPv6 GNU-getopt D=
Bus no-i18n IDN DHCP DHCPv6 no-Lua TFTP no-conntrack ipset auth DNSSEC loop=
-detect
Mar 05 23:39:11 w530 dnsmasq-dhcp[1350]: DHCP, IP range 192.168.122.2 -- 19=
2.168.122.254, lease time 1h
Mar 05 23:39:11 w530 dnsmasq-dhcp[1350]: DHCP, sockets bound exclusively to=
 interface virbr0
Mar 05 23:39:11 w530 dnsmasq[1350]: reading /etc/resolv.conf
Mar 05 23:39:11 w530 dnsmasq[1350]: using nameserver 87.216.1.65#53
Mar 05 23:39:11 w530 dnsmasq[1350]: using nameserver 87.216.1.66#53
Mar 05 23:39:11 w530 dnsmasq[1350]: read /etc/hosts - 2 addresses
Mar 05 23:39:11 w530 dnsmasq[1350]: read /var/lib/libvirt/dnsmasq/default.a=
ddnhosts - 0 addresses
Mar 05 23:39:11 w530 dnsmasq-dhcp[1350]: read /var/lib/libvirt/dnsmasq/defa=
ult.hostsfile
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 3 of 5 (IP Configure Start) scheduled.
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 3 of 5 (IP Configure Start) started...
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): device state ch=
ange: config -> ip-config (reason 'none') [50 70 0]
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 5 of 5 (IPv4 Configure Commit) scheduled...
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): IPv6 config wai=
ting until carrier is on
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 3 of 5 (IP Configure Start) complete.
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 5 of 5 (IPv4 Commit) started...
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): device state ch=
ange: ip-config -> ip-check (reason 'none') [70 80 0]
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) Stage=
 5 of 5 (IPv4 Commit) complete.
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): device state ch=
ange: ip-check -> secondaries (reason 'none') [80 90 0]
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  (virbr0): device state ch=
ange: secondaries -> activated (reason 'none') [90 100 0]
Mar 05 23:39:11 w530 NetworkManager[877]: <info>  Activation (virbr0) succe=
ssful, device activated.
Mar 05 23:39:11 w530 nm-dispatcher[1242]: Dispatching action 'up' for virbr0
Mar 05 23:39:11 w530 systemd[1]: Unit iscsi.service cannot be reloaded beca=
use it is inactive.
Mar 05 23:39:11 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:39:11 w530 systemd-logind[775]: New session c1 of user gdm.
Mar 05 23:39:11 w530 systemd[1380]: pam_unix(systemd-user:session): session=
 opened for user gdm by (uid=3D0)
Mar 05 23:39:11 w530 systemd[1380]: Starting Paths.
Mar 05 23:39:11 w530 systemd[1380]: Reached target Paths.
Mar 05 23:39:11 w530 systemd[1380]: Starting Timers.
Mar 05 23:39:11 w530 systemd[1380]: Reached target Timers.
Mar 05 23:39:11 w530 systemd[1380]: Starting Sockets.
Mar 05 23:39:11 w530 systemd[1380]: Reached target Sockets.
Mar 05 23:39:11 w530 systemd[1380]: Starting Basic System.
Mar 05 23:39:11 w530 systemd[1380]: Reached target Basic System.
Mar 05 23:39:11 w530 systemd[1380]: Starting Default.
Mar 05 23:39:11 w530 systemd[1380]: Reached target Default.
Mar 05 23:39:11 w530 systemd[1380]: Startup finished in 5ms.
Mar 05 23:39:11 w530 gdm-launch-environment][1337]: pam_unix(gdm-launch-env=
ironment:session): session opened for user gdm by (uid=3D0)
Mar 05 23:39:11 w530 org.a11y.Bus[1393]: Activating service name=3D'org.a11=
y.atspi.Registry'
Mar 05 23:39:11 w530 org.a11y.Bus[1393]: Successfully activated service 'or=
g.a11y.atspi.Registry'
Mar 05 23:39:11 w530 org.a11y.atspi.Registry[1401]: SpiRegistry daemon is r=
unning with well-known name - org.a11y.atspi.Registry
Mar 05 23:39:11 w530 org.a11y.atspi.Registry[1401]: Xlib:  extension "XEVIE=
" missing on display ":0".
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_context_destroy_ioctl] HW contex=
t 1 destroyed
Mar 05 23:39:11 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.UPower' unit=3D'upower.service'
Mar 05 23:39:11 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.UPower'
Mar 05 23:39:11 w530 upowerd[1419]: (upowerd:1419): UPower-Linux-WARNING **=
: energy_full (57,510000) is greater than energy_full_design (56,160000)
Mar 05 23:39:11 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.ColorManager' unit=3D'colord.service'
Mar 05 23:39:11 w530 gnome-session[1389]: Entering running state
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:11 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:11 w530 kernel: [drm:intel_lvds_detect] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:11 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:18:LVDS-1] probed modes :
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_debug_printmodeline] Modeline 21=
:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 1130 0x48 0xa
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_debug_printmodeline] Modeline 22=
:"1920x1080" 50 115830 1920 1980 2028 2050 1080 1090 1100 1130 0x40 0xa
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): EDID vendor "LEN", p=
rod id 16562
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Printing DDC gathere=
d Modelines:
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Modeline "1920x1080"=
x0.0  139.00  1920 1980 2028 2050  1080 1090 1100 1130 -hsync -vsync (67.8 =
kHz eP)
Mar 05 23:39:11 w530 gdm-Xorg-:0[1293]: (II) intel(0): Modeline "1920x1080"=
x0.0  115.83  1920 1980 2028 2050  1080 1090 1100 1130 -hsync -vsync (56.5 =
kHz e)
Mar 05 23:39:11 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:26:?]
Mar 05 23:39:11 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:26:VGA-1]
Mar 05 23:39:11 w530 kernel: [drm:intel_crt_detect] [CONNECTOR:26:VGA-1] fo=
rce=3D1
Mar 05 23:39:11 w530 kernel: [drm:intel_ironlake_crt_detect_hotplug] ironla=
ke hotplug adpa=3D0xf40000, result 0
Mar 05 23:39:11 w530 kernel: [drm:intel_crt_detect] CRT not detected via ho=
tplug
Mar 05 23:39:11 w530 kernel: [drm:drm_do_probe_ddc_edid] drm: skipping non-=
existent adapter i915 gmbus vga
Mar 05 23:39:11 w530 kernel: [drm:intel_crt_detect_ddc] CRT not detected vi=
a DDC:0x50 [no valid EDID found]
Mar 05 23:39:11 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:26:VGA-1] disconnected
Mar 05 23:39:11 w530 rtkit-daemon[762]: Successfully made thread 1460 of pr=
ocess 1460 (/usr/bin/pulseaudio) owned by '42' high priority at nice level =
-11.
Mar 05 23:39:11 w530 rtkit-daemon[762]: Supervising 1 threads of 1 processe=
s of 1 users.
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:39:11 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.ColorManager'
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_context_destroy_ioctl] HW contex=
t 1 destroyed
Mar 05 23:39:11 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created
Mar 05 23:39:11 w530 rtkit-daemon[762]: Supervising 1 threads of 1 processe=
s of 1 users.
Mar 05 23:39:11 w530 rtkit-daemon[762]: Successfully made thread 1468 of pr=
ocess 1460 (/usr/bin/pulseaudio) owned by '42' RT at priority 5.
Mar 05 23:39:11 w530 rtkit-daemon[762]: Supervising 2 threads of 1 processe=
s of 1 users.
Mar 05 23:39:11 w530 rtkit-daemon[762]: Supervising 2 threads of 1 processe=
s of 1 users.
Mar 05 23:39:11 w530 rtkit-daemon[762]: Successfully made thread 1471 of pr=
ocess 1460 (/usr/bin/pulseaudio) owned by '42' RT at priority 5.
Mar 05 23:39:11 w530 rtkit-daemon[762]: Supervising 3 threads of 1 processe=
s of 1 users.
Mar 05 23:39:11 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.locale1' unit=3D'dbus-org.freedesktop.locale1.service'
Mar 05 23:39:11 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:39:11 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.locale1'
Mar 05 23:39:12 w530 gdm-Xorg-:0[1293]: The XKEYBOARD keymap compiler (xkbc=
omp) reports:
Mar 05 23:39:12 w530 gdm-Xorg-:0[1293]: > Warning:          Type "ONE_LEVEL=
" has 1 levels, but <RALT> has 2 symbols
Mar 05 23:39:12 w530 gdm-Xorg-:0[1293]: >                   Ignoring extra =
symbols
Mar 05 23:39:12 w530 gdm-Xorg-:0[1293]: Errors from xkbcomp are not fatal t=
o the X server
Mar 05 23:39:12 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.GeoClue2' unit=3D'geoclue.service'
Mar 05 23:39:12 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.GeoClue2'
Mar 05 23:39:12 w530 polkitd[808]: Registered Authentication Agent for unix=
-session:c1 (system bus name :1.25 [gnome-shell --mode=3Dgdm], object path =
/org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_DK.UTF-8)
Mar 05 23:39:12 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.PackageKit' unit=3D'packagekit.service'
Mar 05 23:39:12 w530 PackageKit[1516]: daemon start
Mar 05 23:39:12 w530 org.gnome.OnlineAccounts[1393]: goa-daemon-Message: go=
a-daemon version 3.14.3 starting
Mar 05 23:39:12 w530 org.gnome.OnlineAccounts[1393]: (goa-daemon:1509): lib=
goaidentity-WARNING **: GoaKerberosIdentityManager: Using polling for chang=
e notification for credential cache type 'KEYRING'
Mar 05 23:39:12 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.PackageKit'
Mar 05 23:39:12 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.UDisks2' unit=3D'udisks2.service'
Mar 05 23:39:12 w530 udisksd[1530]: udisks daemon version 2.1.3 starting
Mar 05 23:39:12 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.UDisks2'
Mar 05 23:39:12 w530 udisksd[1530]: Acquired the name org.freedesktop.UDisk=
s2 on the system message bus
Mar 05 23:39:12 w530 org.gtk.Private.AfcVolumeMonitor[1393]: Volume monitor=
 alive
Mar 05 23:39:12 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:12 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:12 w530 kernel: [drm:intel_lvds_detect] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:12 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:18:LVDS-1] probed modes :
Mar 05 23:39:12 w530 kernel: [drm:drm_mode_debug_printmodeline] Modeline 21=
:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 1130 0x48 0xa
Mar 05 23:39:12 w530 kernel: [drm:drm_mode_debug_printmodeline] Modeline 22=
:"1920x1080" 50 115830 1920 1980 2028 2050 1080 1090 1100 1130 0x40 0xa
Mar 05 23:39:12 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:12 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:26:?]
Mar 05 23:39:12 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:26:VGA-1]
Mar 05 23:39:12 w530 kernel: [drm:intel_crt_detect] [CONNECTOR:26:VGA-1] fo=
rce=3D1
Mar 05 23:39:12 w530 kernel: [drm:intel_ironlake_crt_detect_hotplug] ironla=
ke hotplug adpa=3D0xf40000, result 0
Mar 05 23:39:12 w530 kernel: [drm:intel_crt_detect] CRT not detected via ho=
tplug
Mar 05 23:39:12 w530 kernel: [drm:drm_do_probe_ddc_edid] drm: skipping non-=
existent adapter i915 gmbus vga
Mar 05 23:39:12 w530 kernel: [drm:intel_crt_detect_ddc] CRT not detected vi=
a DDC:0x50 [no valid EDID found]
Mar 05 23:39:12 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:26:VGA-1] disconnected
Mar 05 23:39:12 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'net.reactivated.Fprint' unit=3D'fprintd.service'
Mar 05 23:39:12 w530 dbus[778]: [system] Successfully activated service 'ne=
t.reactivated.Fprint'
Mar 05 23:39:12 w530 kernel: [drm:drm_mode_addfb] [FB:28]
Mar 05 23:39:12 w530 kernel: [drm:drm_mode_addfb] [FB:32]
Mar 05 23:39:12 w530 kernel: [drm:drm_mode_addfb] [FB:33]
Mar 05 23:39:12 w530 gnome-session[1389]: Gjs-Message: JS LOG: GNOME Shell =
started at Thu Mar 05 2015 23:39:12 GMT+0100 (CET)
Mar 05 23:39:13 w530 gdm-Xorg-:0[1293]: The XKEYBOARD keymap compiler (xkbc=
omp) reports:
Mar 05 23:39:13 w530 gdm-Xorg-:0[1293]: > Warning:          Type "ONE_LEVEL=
" has 1 levels, but <RALT> has 2 symbols
Mar 05 23:39:13 w530 gdm-Xorg-:0[1293]: >                   Ignoring extra =
symbols
Mar 05 23:39:13 w530 gdm-Xorg-:0[1293]: Errors from xkbcomp are not fatal t=
o the X server
Mar 05 23:39:16 w530 chronyd[791]: Selected source 176.31.53.99
Mar 05 23:39:19 w530 gdm-password][1643]: gkr-pam: no password is available=
 for user
Mar 05 23:39:19 w530 fprintd[1582]: ** Message: user 'johndoe' claiming the=
 device: 0
Mar 05 23:39:19 w530 fprintd[1582]: ** Message: now monitoring fd 15
Mar 05 23:39:19 w530 fprintd[1582]: ** Message: device 0 claim status 0
Mar 05 23:39:19 w530 fprintd[1582]: ** Message: no longer monitoring fd 15
Mar 05 23:39:19 w530 fprintd[1582]: ** Message: released device 0
Mar 05 23:39:19 w530 kernel: SELinux: initialized (dev tmpfs, type tmpfs), =
uses transition SIDs
Mar 05 23:39:19 w530 systemd-logind[775]: New session 1 of user johndoe.
Mar 05 23:39:19 w530 systemd[1653]: pam_unix(systemd-user:session): session=
 opened for user johndoe by (uid=3D0)
Mar 05 23:39:19 w530 systemd[1653]: Starting Paths.
Mar 05 23:39:19 w530 systemd[1653]: Reached target Paths.
Mar 05 23:39:19 w530 systemd[1653]: Starting Timers.
Mar 05 23:39:19 w530 systemd[1653]: Reached target Timers.
Mar 05 23:39:19 w530 systemd[1653]: Starting Sockets.
Mar 05 23:39:19 w530 systemd[1653]: Reached target Sockets.
Mar 05 23:39:19 w530 systemd[1653]: Starting Basic System.
Mar 05 23:39:19 w530 systemd[1653]: Reached target Basic System.
Mar 05 23:39:19 w530 systemd[1653]: Starting Default.
Mar 05 23:39:19 w530 systemd[1653]: Reached target Default.
Mar 05 23:39:19 w530 systemd[1653]: Startup finished in 8ms.
Mar 05 23:39:19 w530 gdm-password][1643]: pam_unix(gdm-password:session): s=
ession opened for user johndoe by (unknown)(uid=3D0)
Mar 05 23:39:19 w530 org.gtk.vfs.Daemon[1393]: A connection to the bus can'=
t be made
Mar 05 23:39:19 w530 org.a11y.Bus[1393]: g_dbus_connection_real_closed: Rem=
ote peer vanished with error: Underlying GIOStream returned 0 bytes on an a=
sync read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.gtk.vfs.Daemon[1393]: g_dbus_connection_real_close=
d: Remote peer vanished with error: Underlying GIOStream returned 0 bytes o=
n an async read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.a11y.atspi.Registry[1401]: g_dbus_connection_real_=
closed: Remote peer vanished with error: Underlying GIOStream returned 0 by=
tes on an async read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 gnome-session[1389]: (gnome-settings-daemon:1412): GLi=
b-GIO-WARNING **: Error releasing name org.gnome.SettingsDaemon: The connec=
tion is closed
Mar 05 23:39:19 w530 ca.desrt.dconf[1393]: g_dbus_connection_real_closed: R=
emote peer vanished with error: Underlying GIOStream returned 0 bytes on an=
 async read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 gnome-session[1389]: g_dbus_connection_real_closed: Re=
mote peer vanished with error: Underlying GIOStream returned 0 bytes on an =
async read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.freedesktop.Telepathy.AccountManager[1393]: g_dbus=
_connection_real_closed: Remote peer vanished with error: Underlying GIOStr=
eam returned 0 bytes on an async read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.gnome.OnlineAccounts[1393]: g_dbus_connection_real=
_closed: Remote peer vanished with error: Underlying GIOStream returned 0 b=
ytes on an async read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.gtk.Private.GPhoto2VolumeMonitor[1393]: g_dbus_con=
nection_real_closed: Remote peer vanished with error: Error receiving messa=
ge: Connection reset by peer (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.gtk.Private.GoaVolumeMonitor[1393]: g_dbus_connect=
ion_real_closed: Remote peer vanished with error: Error receiving message: =
Connection reset by peer (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.gtk.Private.AfcVolumeMonitor[1393]: g_dbus_connect=
ion_real_closed: Remote peer vanished with error: Error receiving message: =
Connection reset by peer (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.gtk.Private.MTPVolumeMonitor[1393]: g_dbus_connect=
ion_real_closed: Remote peer vanished with error: Error receiving message: =
Connection reset by peer (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.gtk.Private.UDisks2VolumeMonitor[1393]: g_dbus_con=
nection_real_closed: Remote peer vanished with error: Underlying GIOStream =
returned 0 bytes on an async read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 org.gnome.Caribou.Daemon[1393]: ** (caribou:1511): WAR=
NING **: daemon.vala:185: can't hide keyboard: The connection is closed
Mar 05 23:39:19 w530 org.gnome.Caribou.Daemon[1393]: ** (caribou:1511): WAR=
NING **: daemon.vala:191: can't deregister event listeners: Connection is c=
losed
Mar 05 23:39:19 w530 org.gnome.Caribou.Daemon[1393]: g_dbus_connection_real=
_closed: Remote peer vanished with error: Underlying GIOStream returned 0 b=
ytes on an async read (g-io-error-quark, 0). Exiting.
Mar 05 23:39:19 w530 kernel: [drm:add_framebuffer_internal] [FB:28]
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 2 created
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_context_destroy_ioctl] HW contex=
t 1 destroyed
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_context_destroy_ioctl] HW contex=
t 2 destroyed
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_context_destroy_ioctl] HW contex=
t 1 destroyed
Mar 05 23:39:19 w530 polkitd[808]: Unregistered Authentication Agent for un=
ix-session:c1 (system bus name :1.25, object path /org/freedesktop/PolicyKi=
t1/AuthenticationAgent, locale en_DK.UTF-8) (disconnected from bus)
Mar 05 23:39:19 w530 org.a11y.Bus[1757]: Activating service name=3D'org.a11=
y.atspi.Registry'
Mar 05 23:39:19 w530 org.a11y.Bus[1757]: Successfully activated service 'or=
g.a11y.atspi.Registry'
Mar 05 23:39:19 w530 org.a11y.atspi.Registry[1805]: SpiRegistry daemon is r=
unning with well-known name - org.a11y.atspi.Registry
Mar 05 23:39:19 w530 org.a11y.atspi.Registry[1805]: Xlib:  extension "XEVIE=
" missing on display ":0".
Mar 05 23:39:19 w530 kernel: fuse init (API version 7.23)
Mar 05 23:39:19 w530 kernel: SELinux: initialized (dev fuse, type fuse), us=
es genfs_contexts
Mar 05 23:39:19 w530 kernel: SELinux: initialized (dev fusectl, type fusect=
l), uses genfs_contexts
Mar 05 23:39:19 w530 gnome-session[1745]: GPG_AGENT_INFO=3D/run/user/1000/k=
eyring/gpg:0:1
Mar 05 23:39:19 w530 gnome-session[1745]: GPG_AGENT_INFO=3D/run/user/1000/k=
eyring/gpg:0:1
Mar 05 23:39:19 w530 gnome-session[1745]: GPG_AGENT_INFO=3D/run/user/1000/k=
eyring/gpg:0:1
Mar 05 23:39:19 w530 gnome-session[1745]: SSH_AUTH_SOCK=3D/run/user/1000/ke=
yring/ssh
Mar 05 23:39:19 w530 rtkit-daemon[762]: Successfully made thread 1855 of pr=
ocess 1855 (/usr/bin/pulseaudio) owned by '1000' high priority at nice leve=
l -11.
Mar 05 23:39:19 w530 rtkit-daemon[762]: Supervising 4 threads of 2 processe=
s of 2 users.
Mar 05 23:39:19 w530 rtkit-daemon[762]: Supervising 4 threads of 2 processe=
s of 2 users.
Mar 05 23:39:19 w530 rtkit-daemon[762]: Successfully made thread 1862 of pr=
ocess 1855 (/usr/bin/pulseaudio) owned by '1000' RT at priority 5.
Mar 05 23:39:19 w530 rtkit-daemon[762]: Supervising 5 threads of 2 processe=
s of 2 users.
Mar 05 23:39:19 w530 rtkit-daemon[762]: Supervising 5 threads of 2 processe=
s of 2 users.
Mar 05 23:39:19 w530 rtkit-daemon[762]: Successfully made thread 1866 of pr=
ocess 1855 (/usr/bin/pulseaudio) owned by '1000' RT at priority 5.
Mar 05 23:39:19 w530 rtkit-daemon[762]: Supervising 6 threads of 2 processe=
s of 2 users.
Mar 05 23:39:19 w530 bluetoothd[919]: Endpoint registered: sender=3D:1.48 p=
ath=3D/MediaEndpoint/A2DPSource
Mar 05 23:39:19 w530 bluetoothd[919]: Endpoint registered: sender=3D:1.48 p=
ath=3D/MediaEndpoint/A2DPSink
Mar 05 23:39:19 w530 kernel: [drm:intel_crtc_cursor_set_obj] cursor off
Mar 05 23:39:19 w530 kernel: Bluetooth: RFCOMM TTY layer initialized
Mar 05 23:39:19 w530 kernel: Bluetooth: RFCOMM socket layer initialized
Mar 05 23:39:19 w530 kernel: Bluetooth: RFCOMM ver 1.11
Mar 05 23:39:19 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:19 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:19 w530 kernel: [drm:intel_lvds_detect] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:19 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:18:LVDS-1] probed modes :
Mar 05 23:39:19 w530 kernel: [drm:drm_mode_debug_printmodeline] Modeline 21=
:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 1130 0x48 0xa
Mar 05 23:39:19 w530 kernel: [drm:drm_mode_debug_printmodeline] Modeline 22=
:"1920x1080" 50 115830 1920 1980 2028 2050 1080 1090 1100 1130 0x40 0xa
Mar 05 23:39:19 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:19 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:26:?]
Mar 05 23:39:19 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:26:VGA-1]
Mar 05 23:39:19 w530 kernel: [drm:intel_crt_detect] [CONNECTOR:26:VGA-1] fo=
rce=3D1
Mar 05 23:39:19 w530 kernel: [drm:intel_ironlake_crt_detect_hotplug] ironla=
ke hotplug adpa=3D0xf40000, result 0
Mar 05 23:39:19 w530 kernel: [drm:intel_crt_detect] CRT not detected via ho=
tplug
Mar 05 23:39:19 w530 kernel: [drm:drm_do_probe_ddc_edid] drm: skipping non-=
existent adapter i915 gmbus vga
Mar 05 23:39:19 w530 kernel: [drm:intel_crt_detect_ddc] CRT not detected vi=
a DDC:0x50 [no valid EDID found]
Mar 05 23:39:19 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:26:VGA-1] disconnected
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created
Mar 05 23:39:19 w530 kernel: [drm:i915_gem_context_destroy_ioctl] HW contex=
t 1 destroyed
Mar 05 23:39:20 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created
Mar 05 23:39:20 w530 org.gnome.OnlineAccounts[1757]: goa-daemon-Message: go=
a-daemon version 3.14.3 starting
Mar 05 23:39:20 w530 org.gnome.OnlineAccounts[1757]: (goa-daemon:1928): lib=
goaidentity-WARNING **: GoaKerberosIdentityManager: Using polling for chang=
e notification for credential cache type 'KEYRING'
Mar 05 23:39:20 w530 gdm-Xorg-:0[1293]: The XKEYBOARD keymap compiler (xkbc=
omp) reports:
Mar 05 23:39:20 w530 gdm-Xorg-:0[1293]: > Warning:          Type "ONE_LEVEL=
" has 1 levels, but <RALT> has 2 symbols
Mar 05 23:39:20 w530 gdm-Xorg-:0[1293]: >                   Ignoring extra =
symbols
Mar 05 23:39:20 w530 gdm-Xorg-:0[1293]: Errors from xkbcomp are not fatal t=
o the X server
Mar 05 23:39:20 w530 dbus[778]: [system] Activating via systemd: service na=
me=3D'org.freedesktop.GeoClue2' unit=3D'geoclue.service'
Mar 05 23:39:20 w530 dbus[778]: [system] Successfully activated service 'or=
g.freedesktop.GeoClue2'
Mar 05 23:39:20 w530 polkitd[808]: Registered Authentication Agent for unix=
-session:1 (system bus name :1.52 [/usr/bin/gnome-shell], object path /org/=
freedesktop/PolicyKit1/AuthenticationAgent, locale en_DK.UTF-8)
Mar 05 23:39:20 w530 org.gtk.Private.AfcVolumeMonitor[1757]: Volume monitor=
 alive
Mar 05 23:39:20 w530 gnome-session[1745]: (uint32 1,)
Mar 05 23:39:20 w530 gnome-session[1745]: Entering running state
Mar 05 23:39:20 w530 gnome-session[1745]: vmware-user: could not open /proc=
/fs/vmblock/dev
Mar 05 23:39:20 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:20 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:20 w530 kernel: [drm:intel_lvds_detect] [CONNECTOR:18:LVDS-1]
Mar 05 23:39:20 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:18:LVDS-1] probed modes :
Mar 05 23:39:20 w530 kernel: [drm:drm_mode_debug_printmodeline] Modeline 21=
:"1920x1080" 60 139000 1920 1980 2028 2050 1080 1090 1100 1130 0x48 0xa
Mar 05 23:39:20 w530 kernel: [drm:drm_mode_debug_printmodeline] Modeline 22=
:"1920x1080" 50 115830 1920 1980 2028 2050 1080 1090 1100 1130 0x40 0xa
Mar 05 23:39:20 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:18:?]
Mar 05 23:39:20 w530 kernel: [drm:drm_mode_getconnector] [CONNECTOR:26:?]
Mar 05 23:39:20 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:26:VGA-1]
Mar 05 23:39:20 w530 kernel: [drm:intel_crt_detect] [CONNECTOR:26:VGA-1] fo=
rce=3D1
Mar 05 23:39:20 w530 kernel: [drm:intel_ironlake_crt_detect_hotplug] ironla=
ke hotplug adpa=3D0xf40000, result 0
Mar 05 23:39:20 w530 kernel: [drm:intel_crt_detect] CRT not detected via ho=
tplug
Mar 05 23:39:20 w530 vmusr[2090]: [ warning] [vmtoolsd] The vmusr service n=
eeds to run inside a virtual machine.
Mar 05 23:39:20 w530 kernel: [drm:drm_do_probe_ddc_edid] drm: skipping non-=
existent adapter i915 gmbus vga
Mar 05 23:39:20 w530 kernel: [drm:intel_crt_detect_ddc] CRT not detected vi=
a DDC:0x50 [no valid EDID found]
Mar 05 23:39:20 w530 kernel: [drm:drm_helper_probe_single_connector_modes_m=
erge_bits] [CONNECTOR:26:VGA-1] disconnected
Mar 05 23:39:20 w530 gnome-session[1745]: Failed to play sound: File or dat=
a not found
Mar 05 23:39:20 w530 org.gnome.Caribou.Daemon[1757]: ** (caribou:1966): WAR=
NING **: AT-SPI: Error in GetItems, sender=3Dorg.freedesktop.DBus, error=3D=
The name :1.5 was not provided by any .service files
Mar 05 23:39:20 w530 gnome-session[1745]: (gnome-shell:1878): IBUS-WARNING =
**: Unable to connect to ibus: Could not connect: Connection refused
Mar 05 23:39:20 w530 gnome-session[1745]: (gnome-shell:1878): mutter-WARNIN=
G **: STACK_OP_ADD: window 0x1c00001 already in stack
Mar 05 23:39:20 w530 gnome-session[1745]: (gnome-shell:1878): mutter-WARNIN=
G **: STACK_OP_ADD: window 0x1c00001 already in stack
Mar 05 23:39:20 w530 kernel: [drm:drm_mode_addfb] [FB:32]
Mar 05 23:39:20 w530 kernel: [drm:drm_mode_addfb] [FB:33]
Mar 05 23:39:21 w530 kernel: [drm:drm_mode_addfb] [FB:34]
Mar 05 23:39:21 w530 gdm-Xorg-:0[1293]: The XKEYBOARD keymap compiler (xkbc=
omp) reports:
Mar 05 23:39:21 w530 gdm-Xorg-:0[1293]: > Warning:          Type "ONE_LEVEL=
" has 1 levels, but <RALT> has 2 symbols
Mar 05 23:39:21 w530 gdm-Xorg-:0[1293]: >                   Ignoring extra =
symbols
Mar 05 23:39:21 w530 gdm-Xorg-:0[1293]: Errors from xkbcomp are not fatal t=
o the X server
Mar 05 23:39:21 w530 gnome-session[1745]: GNOME Shell started at Thu Mar 05=
 2015 23:39:20 GMT+0100 (CET)
Mar 05 23:39:23 w530 gnome-session[1745]: Gjs-Message: JS LOG: The property=
 brightness doesn't seem to be a normal object property of [0x51f39a0 StWid=
get] or a registered special property
Mar 05 23:39:23 w530 gnome-session[1745]: Gjs-Message: JS LOG: The property=
 vignette_sharpness doesn't seem to be a normal object property of [0x51f39=
a0 StWidget] or a registered special property
Mar 05 23:39:23 w530 kernel: [drm:add_framebuffer_internal] [FB:35]
Mar 05 23:39:26 w530 kernel: [drm:intel_crtc_cursor_set_obj] cursor off
Mar 05 23:39:38 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 4 of 5 (IPv6 Configure Timeout) scheduled...
Mar 05 23:39:38 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 4 of 5 (IPv6 Configure Timeout) started...
Mar 05 23:39:38 w530 NetworkManager[877]: <info>  Activation (wlp3s0) Stage=
 4 of 5 (IPv6 Configure Timeout) complete.
Mar 05 23:39:39 w530 systemd-logind[775]: Removed session c1.
Mar 05 23:39:39 w530 systemd[1380]: Stopping Default.
Mar 05 23:39:39 w530 systemd[1380]: Stopped target Default.
Mar 05 23:39:39 w530 systemd[1380]: Stopping Basic System.
Mar 05 23:39:39 w530 systemd[1380]: Stopped target Basic System.
Mar 05 23:39:39 w530 systemd[1380]: Stopping Paths.
Mar 05 23:39:39 w530 systemd[1380]: Stopped target Paths.
Mar 05 23:39:39 w530 systemd[1380]: Stopping Timers.
Mar 05 23:39:39 w530 systemd[1380]: Stopped target Timers.
Mar 05 23:39:39 w530 systemd[1380]: Stopping Sockets.
Mar 05 23:39:39 w530 systemd[1380]: Stopped target Sockets.
Mar 05 23:39:39 w530 systemd[1380]: Starting Shutdown.
Mar 05 23:39:39 w530 systemd[1380]: Reached target Shutdown.
Mar 05 23:39:39 w530 systemd[1380]: Starting Exit the Session...
Mar 05 23:39:39 w530 systemd[1380]: Received SIGRTMIN+24 from PID 2249 (kil=
l).
Mar 05 23:39:42 w530 kernel: [drm:add_framebuffer_internal] [FB:36]
Mar 05 23:39:42 w530 kernel: [drm:intel_crtc_cursor_set_obj] cursor off
Mar 05 23:39:49 w530 kernel: [drm:add_framebuffer_internal] [FB:37]
Mar 05 23:39:50 w530 kernel: [drm:intel_crtc_cursor_set_obj] cursor off
Mar 05 23:40:32 w530 kernel: [drm:add_framebuffer_internal] [FB:38]
Mar 05 23:40:32 w530 kernel: [drm:intel_crtc_cursor_set_obj] cursor off
Mar 05 23:40:40 w530 kernel: [drm:add_framebuffer_internal] [FB:39]
Mar 05 23:40:41 w530 kernel: [drm:intel_crtc_cursor_set_obj] cursor off
Mar 05 23:40:45 w530 kernel: [drm:add_framebuffer_internal] [FB:40]
Mar 05 23:40:45 w530 kernel: [drm:intel_crtc_cursor_set_obj] cursor off
Mar 05 23:40:51 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:40:51 w530 kernel: [drm:add_framebuffer_internal] [FB:41]
Mar 05 23:40:51 w530 kernel: [drm:i915_gem_open]=20
Mar 05 23:40:51 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created
Mar 05 23:40:51 w530 kernel: [drm:i915_gem_context_destroy_ioctl] HW contex=
t 1 destroyed
Mar 05 23:40:51 w530 kernel: [drm:i915_gem_context_create_ioctl] HW context=
 1 created

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=iomem_fedora_19.txt

00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000cbfff : pnp 00:00
000cc000-000cffff : pnp 00:00
000d0000-000d0fff : Adapter ROM
000d4000-000d7fff : pnp 00:00
000d8000-000dbfff : pnp 00:00
000dc000-000dffff : pnp 00:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-01652743 : Kernel code
  01652744-01ced8bf : Kernel data
  01e48000-01fc2fff : Kernel bss
20000000-201fffff : reserved
20200000-40003fff : System RAM
40004000-40004fff : reserved
40005000-a59f3fff : System RAM
a59f4000-bae9efff : reserved
bae9f000-baf9efff : ACPI Non-volatile Storage
baf9f000-baffefff : ACPI Tables
bafff000-bf9fffff : reserved
bfa00000-febfffff : PCI Bus 0000:00
  c0000000-d1ffffff : PCI Bus 0000:01
    c0000000-cfffffff : 0000:01:00.0
    d0000000-d1ffffff : 0000:01:00.0
  e0000000-efffffff : 0000:00:02.0
  f0000000-f10fffff : PCI Bus 0000:01
    f0000000-f0ffffff : 0000:01:00.0
    f1000000-f107ffff : 0000:01:00.0
  f1400000-f17fffff : 0000:00:02.0
  f1800000-f1ffffff : PCI Bus 0000:02
  f2000000-f27fffff : PCI Bus 0000:04
  f2800000-f2ffffff : PCI Bus 0000:04
  f3000000-f30fffff : PCI Bus 0000:03
    f3000000-f3001fff : 0000:03:00.0
      f3000000-f3001fff : iwlwifi
  f3100000-f39fffff : PCI Bus 0000:02
    f3100000-f31007ff : 0000:02:00.3
      f3100000-f31007ff : firewire_ohci
    f3101000-f31010ff : 0000:02:00.0
      f3101000-f31010ff : mmc0
  f3a00000-f3a1ffff : 0000:00:19.0
    f3a00000-f3a1ffff : e1000e
  f3a20000-f3a2ffff : 0000:00:14.0
    f3a20000-f3a2ffff : xhci_hcd
  f3a30000-f3a33fff : 0000:00:1b.0
    f3a30000-f3a33fff : ICH HD audio
  f3a34000-f3a340ff : 0000:00:1f.3
  f3a35000-f3a3500f : 0000:00:16.0
    f3a35000-f3a3500f : mei
  f3a38000-f3a387ff : 0000:00:1f.2
    f3a38000-f3a387ff : ahci
  f3a39000-f3a393ff : 0000:00:1d.0
    f3a39000-f3a393ff : ehci_hcd
  f3a3a000-f3a3a3ff : 0000:00:1a.0
    f3a3a000-f3a3a3ff : ehci_hcd
  f3a3b000-f3a3bfff : 0000:00:19.0
    f3a3b000-f3a3bfff : e1000e
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:01
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed08000-fed08fff : reserved
fed10000-fed19fff : reserved
  fed10000-fed13fff : pnp 00:01
  fed18000-fed18fff : pnp 00:01
  fed19000-fed19fff : pnp 00:01
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:01
    fed1f410-fed1f414 : iTCO_wdt
      fed1f410-fed1f414 : iTCO_wdt
fed40000-fed4bfff : PCI Bus 0000:00
  fed45000-fed4bfff : pnp 00:01
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffc00000-ffffffff : reserved
100000000-83e5fffff : System RAM
83e600000-83effffff : reserved
83f000000-83fffffff : RAM buffer

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=iomem_fedora_21.txt

00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000cbfff : pnp 00:00
000cc000-000cffff : pnp 00:00
000d0000-000d3fff : pnp 00:00
000d4000-000d7fff : pnp 00:00
000d8000-000dbfff : pnp 00:00
000dc000-000dffff : pnp 00:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-0176a6f4 : Kernel code
  0176a6f5-01d34dff : Kernel data
  01eb5000-02038fff : Kernel bss
20000000-201fffff : reserved
20200000-40003fff : System RAM
  2d000000-34ffffff : Crash kernel
40004000-40004fff : reserved
40005000-a59f3fff : System RAM
a59f4000-bae9efff : reserved
bae9f000-baf9efff : ACPI Non-volatile Storage
baf9f000-baffefff : ACPI Tables
bafff000-bf9fffff : reserved
  bba00000-bf9fffff : Graphics Stolen Memory
bfa00000-febfffff : PCI Bus 0000:00
  c0000000-d1ffffff : PCI Bus 0000:01
    c0000000-cfffffff : 0000:01:00.0
    d0000000-d1ffffff : 0000:01:00.0
  e0000000-efffffff : 0000:00:02.0
  f0000000-f10fffff : PCI Bus 0000:01
    f0000000-f0ffffff : 0000:01:00.0
    f1000000-f107ffff : 0000:01:00.0
  f1400000-f17fffff : 0000:00:02.0
  f1800000-f1ffffff : PCI Bus 0000:02
  f2000000-f27fffff : PCI Bus 0000:04
  f2800000-f2ffffff : PCI Bus 0000:04
  f3000000-f30fffff : PCI Bus 0000:03
    f3000000-f3001fff : 0000:03:00.0
      f3000000-f3001fff : iwlwifi
  f3100000-f39fffff : PCI Bus 0000:02
    f3100000-f31007ff : 0000:02:00.3
      f3100000-f31007ff : firewire_ohci
    f3101000-f31010ff : 0000:02:00.0
      f3101000-f31010ff : mmc0
  f3a00000-f3a1ffff : 0000:00:19.0
    f3a00000-f3a1ffff : e1000e
  f3a20000-f3a2ffff : 0000:00:14.0
    f3a20000-f3a2ffff : xhci-hcd
  f3a30000-f3a33fff : 0000:00:1b.0
    f3a30000-f3a33fff : ICH HD audio
  f3a34000-f3a340ff : 0000:00:1f.3
  f3a35000-f3a3500f : 0000:00:16.0
    f3a35000-f3a3500f : mei_me
  f3a38000-f3a387ff : 0000:00:1f.2
    f3a38000-f3a387ff : ahci
  f3a39000-f3a393ff : 0000:00:1d.0
    f3a39000-f3a393ff : ehci_hcd
  f3a3a000-f3a3a3ff : 0000:00:1a.0
    f3a3a000-f3a3a3ff : ehci_hcd
  f3a3b000-f3a3bfff : 0000:00:19.0
    f3a3b000-f3a3bfff : e1000e
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:01
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed08000-fed08fff : reserved
fed10000-fed19fff : reserved
  fed10000-fed17fff : pnp 00:01
  fed18000-fed18fff : pnp 00:01
  fed19000-fed19fff : pnp 00:01
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:01
    fed1f410-fed1f414 : iTCO_wdt
      fed1f410-fed1f414 : iTCO_wdt
fed40000-fed4bfff : PCI Bus 0000:00
  fed45000-fed4bfff : pnp 00:01
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffc00000-ffffffff : reserved
100000000-83e5fffff : System RAM
83e600000-83effffff : reserved
83f000000-83fffffff : RAM buffer

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=ioports_fedora_19.txt

0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  03c0-03df : vga+
  0400-047f : pnp 00:01
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0410-0415 : ACPI CPU throttle
    0420-042f : ACPI GPE0_BLK
    0430-0433 : iTCO_wdt
      0430-0433 : iTCO_wdt
    0450-0450 : ACPI PM2_CNT_BLK
    0460-047f : iTCO_wdt
      0460-047f : iTCO_wdt
  0500-057f : pnp 00:01
  0800-080f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  15e0-15ef : pnp 00:01
  1600-167f : pnp 00:01
  3000-3fff : PCI Bus 0000:04
  4000-4fff : PCI Bus 0000:02
  5000-5fff : PCI Bus 0000:01
    5000-507f : 0000:01:00.0
  6000-603f : 0000:00:02.0
  6060-607f : 0000:00:1f.2
    6060-607f : ahci
  6080-609f : 0000:00:19.0
  60a0-60a7 : 0000:00:1f.2
    60a0-60a7 : ahci
  60a8-60af : 0000:00:1f.2
    60a8-60af : ahci
  60b0-60b3 : 0000:00:1f.2
    60b0-60b3 : ahci
  60b4-60b7 : 0000:00:1f.2
    60b4-60b7 : ahci
  efa0-efbf : 0000:00:1f.3
    efa0-efbf : i801_smbus
    

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=ioports_fedora_21.txt

0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:00
    0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
    00f0-00f0 : PNP0C04:00
  03c0-03df : vga+
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
    0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
    0460-047f : iTCO_wdt
  0500-057f : pnp 00:01
  0800-080f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  15e0-15ef : pnp 00:01
  1600-167f : pnp 00:01
  3000-3fff : PCI Bus 0000:04
  4000-4fff : PCI Bus 0000:02
  5000-5fff : PCI Bus 0000:01
    5000-507f : 0000:01:00.0
  6000-603f : 0000:00:02.0
  6060-607f : 0000:00:1f.2
    6060-607f : ahci
  6080-609f : 0000:00:19.0
  60a0-60a7 : 0000:00:1f.2
    60a0-60a7 : ahci
  60a8-60af : 0000:00:1f.2
    60a8-60af : ahci
  60b0-60b3 : 0000:00:1f.2
    60b0-60b3 : ahci
  60b4-60b7 : 0000:00:1f.2
    60b4-60b7 : ahci
  efa0-efbf : 0000:00:1f.3
    efa0-efbf : i801_smbus

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=lspci_fedora_19.txt

00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: f0000000-f10fffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000d1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Lenovo Device 21f6
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee002f8  Data: 0000
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr+ UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Capabilities: [d94 v1] #19
	Kernel driver in use: pcieport

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21f5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at f1400000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 6000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at f3a20000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee00358  Data: 0000
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1 (rev 04)
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 47
	Region 0: Memory at f3a35000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee003b8  Data: 0000
	Kernel driver in use: mei

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)
	Subsystem: Lenovo Device 21f3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at f3a00000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at f3a3b000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 6080 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00398  Data: 0000
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f3a3a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP+
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at f3a30000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee003f8  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=22
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f3100000-f39fffff
	Prefetchable memory behind bridge: 00000000f1800000-00000000f1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f3000000-f30fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 3 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=0b, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f2800000-f2ffffff
	Prefetchable memory behind bridge: 00000000f2000000-00000000f27fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f3a39000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation QM77 Express Chipset LPC Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Lenovo Device 21f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 43
	Region 0: I/O ports at 60a8 [size=8]
	Region 1: I/O ports at 60b4 [size=4]
	Region 2: I/O ports at 60a0 [size=8]
	Region 3: I/O ports at 60b0 [size=4]
	Region 4: I/O ports at 6060 [size=32]
	Region 5: Memory at f3a38000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00338  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at f3a34000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus

01:00.0 VGA compatible controller: NVIDIA Corporation GK107GLM [Quadro K2000M] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21f5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at d0000000 (64-bit, prefetchable) [size=32M]
	Region 5: I/O ports at 5000 [size=128]
	Expansion ROM at f1000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Latency L0 <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b4] Vendor Specific Information: Len=14 <?>
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [128 v1] Power Budgeting <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
	Capabilities: [900 v1] #19
	Kernel driver in use: nouveau

02:00.0 System peripheral: Ricoh Co Ltd MMC/SD Host Controller (rev 08) (prog-if 01)
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f3101000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [800 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: sdhci-pci

02:00.3 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 PCIe IEEE 1394 Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f3100000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME+
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: firewire_ohci

03:00.0 Network controller: Intel Corporation Centrino Advanced-N 6205 [Taylor Peak] (rev 34)
	Subsystem: Intel Corporation Centrino Advanced-N 6205 AGN
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at f3000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00418  Data: 0000
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 6c-88-14-ff-ff-31-fb-88
	Kernel driver in use: iwlwifi

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=lspci_fedora_21.txt

00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller (rev 09)
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: ivb_uncore

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 26
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: f0000000-f10fffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000d1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Lenovo Device 21f6
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee002d8  Data: 0000
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <256ns, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train+ SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Capabilities: [d94 v1] #19
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21f5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 30
	Region 0: Memory at f1400000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 6000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at f3a20000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee00378  Data: 0000
	Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1 (rev 04)
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at f3a35000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee003f8  Data: 0000
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)
	Subsystem: Lenovo Device 21f3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 29
	Region 0: Memory at f3a00000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at f3a3b000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 6080 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee003d8  Data: 0000
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e
	Kernel modules: e1000e

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f3a3a000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family High Definition Audio Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at f3a30000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00438  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=22
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f3100000-f39fffff
	Prefetchable memory behind bridge: 00000000f1800000-00000000f1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f3000000-f30fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Express Root Port 3 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Bus: primary=00, secondary=04, subordinate=0b, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f2800000-f2ffffff
	Prefetchable memory behind bridge: 00000000f2000000-00000000f27fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21f6
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f3a39000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation QM77 Express Chipset LPC Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Lenovo Device 21f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 27
	Region 0: I/O ports at 60a8 [size=8]
	Region 1: I/O ports at 60b4 [size=4]
	Region 2: I/O ports at 60a0 [size=8]
	Region 3: I/O ports at 60b0 [size=4]
	Region 4: I/O ports at 6060 [size=32]
	Region 5: Memory at f3a38000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00358  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller (rev 04)
	Subsystem: Lenovo Device 21f6
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at f3a34000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at efa0 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

01:00.0 VGA compatible controller: NVIDIA Corporation GK107GLM [Quadro K2000M] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21f5
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 34
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at d0000000 (64-bit, prefetchable) [size=32M]
	Region 5: I/O ports at 5000 [size=128]
	Expansion ROM at f1000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00478  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b4] Vendor Specific Information: Len=14 <?>
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [128 v1] Power Budgeting <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
	Capabilities: [900 v1] #19
	Kernel driver in use: nouveau
	Kernel modules: nouveau

02:00.0 System peripheral: Ricoh Co Ltd PCIe SDXC/MMC Host Controller (rev 08) (prog-if 01)
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f3101000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [800 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci

02:00.3 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 PCIe IEEE 1394 Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: Lenovo Device 21f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f3100000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME+
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: firewire_ohci
	Kernel modules: firewire_ohci

03:00.0 Network controller: Intel Corporation Centrino Advanced-N 6205 [Taylor Peak] (rev 34)
	Subsystem: Intel Corporation Centrino Advanced-N 6205 AGN
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 33
	Region 0: Memory at f3000000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00458  Data: 0000
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 6c-88-14-ff-ff-31-fb-88
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=modules_fedora_19.txt

fuse 82124 3 - Live 0xffffffffa07e1000
ebtable_nat 12807 0 - Live 0xffffffffa07dc000
nf_conntrack_netbios_ns 12665 0 - Live 0xffffffffa07d7000
nf_conntrack_broadcast 12527 1 nf_conntrack_netbios_ns, Live 0xffffffffa07d2000
ipt_MASQUERADE 12880 1 - Live 0xffffffffa07ba000
ip6table_nat 13015 1 - Live 0xffffffffa07b5000
nf_nat_ipv6 13213 1 ip6table_nat, Live 0xffffffffa07b0000
ip6table_mangle 12700 1 - Live 0xffffffffa07ab000
ip6t_REJECT 12939 2 - Live 0xffffffffa07a6000
nf_conntrack_ipv6 18782 24 - Live 0xffffffffa079c000
nf_defrag_ipv6 18205 1 nf_conntrack_ipv6, Live 0xffffffffa0792000
iptable_nat 13011 1 - Live 0xffffffffa0788000
nf_nat_ipv4 13199 1 iptable_nat, Live 0xffffffffa078d000
nf_nat 25743 5 ipt_MASQUERADE,ip6table_nat,nf_nat_ipv6,iptable_nat,nf_nat_ipv4, Live 0xffffffffa0780000
iptable_mangle 12695 1 - Live 0xffffffffa077b000
nf_conntrack_ipv4 14808 20 - Live 0xffffffffa0719000
nf_defrag_ipv4 12673 1 nf_conntrack_ipv4, Live 0xffffffffa0714000
xt_conntrack 12760 42 - Live 0xffffffffa071e000
nf_conntrack 86376 11 nf_conntrack_netbios_ns,nf_conntrack_broadcast,ipt_MASQUERADE,ip6table_nat,nf_nat_ipv6,nf_conntrack_ipv6,iptable_nat,nf_nat_ipv4,nf_nat,nf_conntrack_ipv4,xt_conntrack, Live 0xffffffffa0760000
ebtable_filter 12827 0 - Live 0xffffffffa05cf000
ebtables 30758 2 ebtable_nat,ebtable_filter, Live 0xffffffffa0635000
ip6table_filter 12815 1 - Live 0xffffffffa05bf000
ip6_tables 26808 3 ip6table_nat,ip6table_mangle,ip6table_filter, Live 0xffffffffa05c7000
rfcomm 68903 6 - Live 0xffffffffa0702000
bnep 19704 2 - Live 0xffffffffa0579000
arc4 12608 2 - Live 0xffffffffa0545000
iwldvm 241640 0 - Live 0xffffffffa0724000
mac80211 595898 1 iwldvm, Live 0xffffffffa066f000
btusb 23827 0 - Live 0xffffffffa0513000
bluetooth 356483 22 rfcomm,bnep,btusb, Live 0xffffffffa05dc000
uvcvideo 81017 0 - Live 0xffffffffa05aa000
snd_hda_codec_realtek 46058 1 - Live 0xffffffffa059d000
videobuf2_vmalloc 13163 1 uvcvideo, Live 0xffffffffa05d7000
acpi_cpufreq 19612 1 - Live 0xffffffffa051d000
iwlwifi 112269 1 iwldvm, Live 0xffffffffa0580000
videobuf2_memops 13161 1 videobuf2_vmalloc, Live 0xffffffffa050e000
videobuf2_core 38773 1 uvcvideo, Live 0xffffffffa0503000
snd_hda_intel 44037 4 - Live 0xffffffffa056d000
mperf 12607 1 acpi_cpufreq, Live 0xffffffffa04fe000
videodev 121804 2 uvcvideo,videobuf2_core, Live 0xffffffffa054e000
coretemp 13435 0 - Live 0xffffffffa04ef000
snd_hda_codec 178706 2 snd_hda_codec_realtek,snd_hda_intel, Live 0xffffffffa0642000
kvm_intel 133627 0 - Live 0xffffffffa0523000
media 20444 2 uvcvideo,videodev, Live 0xffffffffa03ce000
cfg80211 517234 3 iwldvm,mac80211,iwlwifi, Live 0xffffffffa046f000
snd_hwdep 17650 1 snd_hda_codec, Live 0xffffffffa04f8000
snd_seq 64849 0 - Live 0xffffffffa07c1000
kvm 439238 1 kvm_intel, Live 0xffffffffa0402000
snd_seq_device 14136 1 snd_seq, Live 0xffffffffa03ae000
snd_pcm 98071 2 snd_hda_intel,snd_hda_codec, Live 0xffffffffa03e9000
iTCO_wdt 13480 0 - Live 0xffffffffa028a000
iTCO_vendor_support 13419 1 iTCO_wdt, Live 0xffffffffa0285000
thinkpad_acpi 78907 1 - Live 0xffffffffa03b9000
snd_page_alloc 18268 2 snd_hda_intel,snd_pcm, Live 0xffffffffa03a1000
snd_timer 28698 2 snd_seq,snd_pcm, Live 0xffffffffa0398000
mei 70788 0 - Live 0xffffffffa03d6000
snd 79388 19 snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_seq,snd_seq_device,snd_pcm,thinkpad_acpi,snd_timer, Live 0xffffffffa0383000
lpc_ich 16977 0 - Live 0xffffffffa027f000
tpm_tis 19123 0 - Live 0xffffffffa0275000
i2c_i801 18136 0 - Live 0xffffffffa025d000
mfd_core 13182 1 lpc_ich, Live 0xffffffffa0252000
tpm 25869 1 tpm_tis, Live 0xffffffffa0246000
soundcore 14491 1 snd, Live 0xffffffffa0109000
tpm_bios 18688 1 tpm, Live 0xffffffffa03b3000
rfkill 21694 6 bluetooth,cfg80211,thinkpad_acpi, Live 0xffffffffa03a7000
joydev 17332 0 - Live 0xffffffffa0257000
microcode 23403 0 - Live 0xffffffffa018a000
uinput 17625 0 - Live 0xffffffffa0184000
isofs 39803 1 - Live 0xffffffffa023b000
squashfs 47827 2 - Live 0xffffffffa016c000
nouveau 983714 1 - Live 0xffffffffa0291000
crc32_pclmul 13113 0 - Live 0xffffffffa0265000
crc32c_intel 22079 0 - Live 0xffffffffa026a000
ghash_clmulni_intel 13259 0 - Live 0xffffffffa017f000
i915 606325 3 - Live 0xffffffffa01a5000
firewire_ohci 40335 0 - Live 0xffffffffa0196000
mxm_wmi 12865 1 nouveau, Live 0xffffffffa0191000
i2c_algo_bit 13257 2 nouveau,i915, Live 0xffffffffa017a000
sdhci_pci 18659 0 - Live 0xffffffffa00f5000
firewire_core 62287 1 firewire_ohci, Live 0xffffffffa011b000
drm_kms_helper 46114 2 nouveau,i915, Live 0xffffffffa010e000
sdhci 38121 1 sdhci_pci, Live 0xffffffffa00fe000
ttm 80208 1 nouveau, Live 0xffffffffa00e0000
crc_itu_t 12613 1 firewire_core, Live 0xffffffffa0045000
mmc_core 112242 1 sdhci, Live 0xffffffffa00c3000
e1000e 245861 0 - Live 0xffffffffa012e000
drm 268517 7 nouveau,i915,drm_kms_helper,ttm, Live 0xffffffffa0080000
ptp 18413 1 e1000e, Live 0xffffffffa0076000
pps_core 18854 1 ptp, Live 0xffffffffa0062000
i2c_core 34059 7 videodev,i2c_i801,nouveau,i915,i2c_algo_bit,drm_kms_helper,drm, Live 0xffffffffa006c000
wmi 18697 2 nouveau,mxm_wmi, Live 0xffffffffa004a000
video 18990 2 nouveau,i915, Live 0xffffffffa003f000
usb_storage 56128 1 - Live 0xffffffffa0053000
sunrpc 252607 1 - Live 0xffffffffa0000000

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=modules_fedora_21.txt

rfcomm 69427 2 - Live 0xffffffffa09d1000
fuse 91371 3 - Live 0xffffffffa09b9000
xt_CHECKSUM 12549 1 - Live 0xffffffffa09b4000
ipt_MASQUERADE 12678 3 - Live 0xffffffffa09aa000
nf_nat_masquerade_ipv4 13203 1 ipt_MASQUERADE, Live 0xffffffffa0623000
ccm 17731 2 - Live 0xffffffffa061d000
nf_conntrack_netbios_ns 12665 0 - Live 0xffffffffa0618000
nf_conntrack_broadcast 12527 1 nf_conntrack_netbios_ns, Live 0xffffffffa0613000
ip6t_rpfilter 12546 1 - Live 0xffffffffa060e000
ip6t_REJECT 12625 2 - Live 0xffffffffa0609000
nf_reject_ipv6 13301 1 ip6t_REJECT, Live 0xffffffffa0604000
xt_conntrack 12760 22 - Live 0xffffffffa05ff000
bnep 19543 2 - Live 0xffffffffa05f9000
ebtable_nat 12807 0 - Live 0xffffffffa09a5000
ebtable_broute 12731 0 - Live 0xffffffffa09af000
bridge 107941 1 ebtable_broute, Live 0xffffffffa0989000
stp 12868 1 bridge, Live 0xffffffffa0984000
llc 13941 2 bridge,stp, Live 0xffffffffa097f000
ebtable_filter 12827 0 - Live 0xffffffffa097a000
ebtables 30758 3 ebtable_nat,ebtable_broute,ebtable_filter, Live 0xffffffffa096d000
ip6table_nat 12864 1 - Live 0xffffffffa0968000
nf_conntrack_ipv6 18738 12 - Live 0xffffffffa0962000
nf_defrag_ipv6 34786 1 nf_conntrack_ipv6, Live 0xffffffffa0954000
nf_nat_ipv6 13862 1 ip6table_nat, Live 0xffffffffa094f000
ip6table_mangle 12700 1 - Live 0xffffffffa094a000
ip6table_security 12710 1 - Live 0xffffffffa0945000
ip6table_raw 12683 1 - Live 0xffffffffa0940000
ip6table_filter 12815 1 - Live 0xffffffffa093b000
ip6_tables 26809 5 ip6table_nat,ip6table_mangle,ip6table_security,ip6table_raw,ip6table_filter, Live 0xffffffffa092f000
iptable_nat 12875 1 - Live 0xffffffffa08e9000
nf_conntrack_ipv4 14656 12 - Live 0xffffffffa08e4000
nf_defrag_ipv4 12702 1 nf_conntrack_ipv4, Live 0xffffffffa0895000
nf_nat_ipv4 13848 1 iptable_nat, Live 0xffffffffa0890000
nf_nat 25180 3 nf_nat_masquerade_ipv4,nf_nat_ipv6,nf_nat_ipv4, Live 0xffffffffa089a000
nf_conntrack 103513 9 nf_nat_masquerade_ipv4,nf_conntrack_netbios_ns,nf_conntrack_broadcast,xt_conntrack,nf_conntrack_ipv6,nf_nat_ipv6,nf_conntrack_ipv4,nf_nat_ipv4,nf_nat, Live 0xffffffffa08c9000
iptable_mangle 12695 1 - Live 0xffffffffa0660000
iptable_security 12705 1 - Live 0xffffffffa0468000
iptable_raw 12678 1 - Live 0xffffffffa0463000
arc4 12608 2 - Live 0xffffffffa063b000
iwldvm 245252 0 - Live 0xffffffffa08f2000
mac80211 658674 1 iwldvm, Live 0xffffffffa07ee000
intel_rapl 18783 0 - Live 0xffffffffa0641000
x86_pkg_temp_thermal 14205 0 - Live 0xffffffffa0636000
coretemp 13441 0 - Live 0xffffffffa046f000
kvm_intel 148304 0 - Live 0xffffffffa08a3000
kvm 471231 1 kvm_intel, Live 0xffffffffa0779000
iTCO_wdt 13480 0 - Live 0xffffffffa0457000
iTCO_vendor_support 13419 1 iTCO_wdt, Live 0xffffffffa042d000
btusb 32336 0 - Live 0xffffffffa062d000
bluetooth 463099 26 rfcomm,bnep,btusb, Live 0xffffffffa0706000
iwlwifi 129699 1 iwldvm, Live 0xffffffffa06e5000
cfg80211 514867 3 iwldvm,mac80211,iwlwifi, Live 0xffffffffa0666000
crct10dif_pclmul 14307 0 - Live 0xffffffffa0628000
crc32_pclmul 13133 0 - Live 0xffffffffa041b000
uvcvideo 81109 0 - Live 0xffffffffa064b000
crc32c_intel 22094 0 - Live 0xffffffffa045c000
nouveau 1376565 1 - Live 0xffffffffa04a7000
videobuf2_vmalloc 13163 1 uvcvideo, Live 0xffffffffa0452000
videobuf2_core 45100 1 uvcvideo, Live 0xffffffffa0420000
ghash_clmulni_intel 13230 0 - Live 0xffffffffa0416000
videobuf2_memops 13161 1 videobuf2_vmalloc, Live 0xffffffffa0411000
v4l2_common 14543 1 videobuf2_core, Live 0xffffffffa03a8000
videodev 152476 3 uvcvideo,videobuf2_core,v4l2_common, Live 0xffffffffa0480000
media 20906 2 uvcvideo,videodev, Live 0xffffffffa040a000
sdhci_pci 23343 0 - Live 0xffffffffa0403000
sdhci 42522 1 sdhci_pci, Live 0xffffffffa0474000
mmc_core 125580 2 sdhci_pci,sdhci, Live 0xffffffffa0432000
serio_raw 13434 0 - Live 0xffffffffa00e7000
thinkpad_acpi 79105 2 - Live 0xffffffffa03ee000
rfkill 21980 6 bluetooth,cfg80211,thinkpad_acpi, Live 0xffffffffa03e0000
tpm_tis 18581 0 - Live 0xffffffffa03e8000
tpm 35109 1 tpm_tis, Live 0xffffffffa038a000
mxm_wmi 12865 1 nouveau, Live 0xffffffffa02ec000
snd_hda_codec_realtek 79613 1 - Live 0xffffffffa03cb000
ttm 92952 1 nouveau, Live 0xffffffffa03b3000
wmi 18820 2 nouveau,mxm_wmi, Live 0xffffffffa03ad000
snd_hda_codec_generic 67600 1 snd_hda_codec_realtek, Live 0xffffffffa0396000
snd_hda_intel 30520 4 - Live 0xffffffffa0374000
snd_hda_controller 30786 1 snd_hda_intel, Live 0xffffffffa0381000
snd_hda_codec 135263 4 snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, Live 0xffffffffa0351000
snd_hwdep 17650 1 snd_hda_codec, Live 0xffffffffa00ee000
snd_seq 70458 0 - Live 0xffffffffa033e000
snd_seq_device 14136 1 snd_seq, Live 0xffffffffa009a000
snd_pcm 105212 3 snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 0xffffffffa0323000
snd_timer 28778 2 snd_seq,snd_pcm, Live 0xffffffffa02db000
snd 80001 20 thinkpad_acpi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_seq,snd_seq_device,snd_pcm,snd_timer, Live 0xffffffffa0307000
mei_me 19568 0 - Live 0xffffffffa031d000
mei 82599 1 mei_me, Live 0xffffffffa02f1000
lpc_ich 21093 0 - Live 0xffffffffa02e5000
shpchp 37040 0 - Live 0xffffffffa02d0000
mfd_core 13182 1 lpc_ich, Live 0xffffffffa02cb000
i2c_i801 18146 0 - Live 0xffffffffa02c1000
soundcore 14496 2 snd_hda_codec,snd, Live 0xffffffffa02bc000
nfsd 293529 1 - Live 0xffffffffa0273000
auth_rpcgss 58540 1 nfsd, Live 0xffffffffa0263000
nfs_acl 12741 1 nfsd, Live 0xffffffffa00a2000
lockd 92864 1 nfsd, Live 0xffffffffa024b000
grace 13094 2 nfsd,lockd, Live 0xffffffffa0095000
sunrpc 283393 7 nfsd,auth_rpcgss,nfs_acl,lockd, Live 0xffffffffa0204000
i915 1006047 3 - Live 0xffffffffa010d000
i2c_algo_bit 13250 2 nouveau,i915, Live 0xffffffffa0032000
drm_kms_helper 93635 2 nouveau,i915, Live 0xffffffffa00f5000
e1000e 238478 0 - Live 0xffffffffa00ab000
drm 305543 8 nouveau,ttm,i915,drm_kms_helper, Live 0xffffffffa0049000
firewire_ohci 44323 0 - Live 0xffffffffa0039000
firewire_core 62559 1 firewire_ohci, Live 0xffffffffa0021000
ptp 19140 1 e1000e, Live 0xffffffffa0010000
pps_core 19130 1 ptp, Live 0xffffffffa0006000
crc_itu_t 12613 1 firewire_core, Live 0xffffffffa0018000
video 19905 2 nouveau,i915, Live 0xffffffffa0000000

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=ver_linux_fedora_19.txt
Content-Transfer-Encoding: quoted-printable

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Fedora release 19 (Schr=C3=B6dinger=E2=80=99s Cat)
NAME=3DFedora
VERSION=3D"19 (Schr=C3=B6dinger=E2=80=99s Cat)"
ID=3Dfedora
VERSION_ID=3D19
PRETTY_NAME=3D"Fedora 19 (Schr=C3=B6dinger=E2=80=99s Cat)"
ANSI_COLOR=3D"0;34"
CPE_NAME=3D"cpe:/o:fedoraproject:fedora:19"
Fedora release 19 (Schr=C3=B6dinger=E2=80=99s Cat)
Fedora release 19 (Schr=C3=B6dinger=E2=80=99s Cat)
Linux localhost 3.9.5-301.fc19.x86_64 #1 SMP Tue Jun 11 19:39:38 UTC 2013 x=
86_64 x86_64 x86_64 GNU/Linux
=20
Gnu C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Gnu make               3.82
util-linux             linux 2.23.1
mount                  linux 2.23.1 (libmount 2.23.0: selinux, debug, asser=
t)
modutils               13
e2fsprogs              1.42.7
PPP                    2.4.5
Linux C Library        > libc.2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.7
Net-tools              1.70-alpha
iproute2              iproute2-ss130430
Kbd                    1.15.5
Sh-utils               8.21
Modules Loaded         fuse ebtable_nat nf_conntrack_netbios_ns nf_conntrac=
k_broadcast ipt_MASQUERADE ip6table_nat nf_nat_ipv6 ip6table_mangle ip6t_RE=
JECT nf_conntrack_ipv6 nf_defrag_ipv6 iptable_nat nf_nat_ipv4 nf_nat iptabl=
e_mangle nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ebtable=
_filter ebtables ip6table_filter ip6_tables rfcomm bnep arc4 iwldvm mac8021=
1 btusb bluetooth uvcvideo snd_hda_codec_realtek videobuf2_vmalloc acpi_cpu=
freq iwlwifi videobuf2_memops videobuf2_core snd_hda_intel mperf videodev c=
oretemp snd_hda_codec kvm_intel media cfg80211 snd_hwdep snd_seq kvm snd_se=
q_device snd_pcm iTCO_wdt iTCO_vendor_support thinkpad_acpi snd_page_alloc =
snd_timer mei snd lpc_ich tpm_tis i2c_i801 mfd_core tpm soundcore tpm_bios =
rfkill joydev microcode uinput isofs squashfs nouveau crc32_pclmul crc32c_i=
ntel ghash_clmulni_intel i915 firewire_ohci mxm_wmi i2c_algo_bit sdhci_pci =
firewire_core drm_kms_helper sdhci ttm crc_itu_t mmc_core e1000e drm ptp pp=
s_core i2c_core wmi video usb_storage sunrpc

free reports:
             total       used       free     shared    buffers     cached
Mem:      32495884    2373844   30122040          0     177924    1332996
-/+ buffers/cache:     862924   31632960
Swap:            0          0          0

/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 2500.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vn=
mi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5587.30
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1200.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vn=
mi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5587.30
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1200.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vn=
mi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5587.30
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1200.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vn=
mi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5587.30
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1200.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vn=
mi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5587.30
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1200.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vn=
mi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5587.30
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1200.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vn=
mi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5587.30
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1200.000
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vn=
mi flexpriority ept vpid fsgsbase smep erms
bogomips	: 5587.30
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=ver_linux_fedora_21.txt
Content-Transfer-Encoding: quoted-printable

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Fedora release 21 (Twenty One)
NAME=3DFedora
VERSION=3D"21 (Twenty One)"
ID=3Dfedora
VERSION_ID=3D21
PRETTY_NAME=3D"Fedora 21 (Twenty One)"
ANSI_COLOR=3D"0;34"
CPE_NAME=3D"cpe:/o:fedoraproject:fedora:21"
HOME_URL=3D"https://fedoraproject.org/"
BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT=3D"Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=3D21
REDHAT_SUPPORT_PRODUCT=3D"Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=3D21
Fedora release 21 (Twenty One)
Fedora release 21 (Twenty One)
Linux w530 3.18.7-200.fc21.x86_64 #1 SMP Wed Feb 11 21:53:17 UTC 2015 x86_6=
4 x86_64 x86_64 GNU/Linux
=20
Gnu C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Gnu make               4.0
util-linux             linux 2.25.2
mount                  linux 2.25.2 (libmount 2.25.0: selinux, assert, debu=
g)
modutils               19
e2fsprogs              1.42.12
PPP                    2.4.7
Linux C Library        > libc.2.20
Dynamic linker (ldd)   2.20
Procps                 3.3.10
Net-tools              2.10-alpha
iproute2              iproute2-ss140804
Kbd                    2.0.2
Sh-utils               8.22
Modules Loaded         rfcomm fuse xt_CHECKSUM ipt_MASQUERADE nf_nat_masque=
rade_ipv4 ccm nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter =
ip6t_REJECT nf_reject_ipv6 xt_conntrack bnep ebtable_nat ebtable_broute bri=
dge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defra=
g_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_=
filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 =
nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw arc4 iwldvm=
 mac80211 intel_rapl x86_pkg_temp_thermal coretemp kvm_intel kvm iTCO_wdt i=
TCO_vendor_support btusb bluetooth iwlwifi cfg80211 crct10dif_pclmul crc32_=
pclmul uvcvideo crc32c_intel nouveau videobuf2_vmalloc videobuf2_core ghash=
_clmulni_intel videobuf2_memops v4l2_common videodev media sdhci_pci sdhci =
mmc_core serio_raw thinkpad_acpi rfkill tpm_tis tpm mxm_wmi snd_hda_codec_r=
ealtek ttm wmi snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_h=
da_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd mei_me mei =
lpc_ich shpchp mfd_core i2c_i801 soundcore nfsd auth_rpcgss nfs_acl lockd g=
race sunrpc i915 i2c_algo_bit drm_kms_helper e1000e drm firewire_ohci firew=
ire_core ptp pps_core crc_itu_t video

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32346316      855128    30630520      200904      860668    3105=
5148
Swap:             0           0           0

/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1612.187
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase smep erms xsaveopt
bugs		:
bogomips	: 5587.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1692.578
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase smep erms xsaveopt
bugs		:
bogomips	: 5587.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1663.484
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase smep erms xsaveopt
bugs		:
bogomips	: 5587.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1506.531
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 1
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase smep erms xsaveopt
bugs		:
bogomips	: 5587.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1604.312
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase smep erms xsaveopt
bugs		:
bogomips	: 5587.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1697.171
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 2
cpu cores	: 4
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase smep erms xsaveopt
bugs		:
bogomips	: 5587.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1633.078
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase smep erms xsaveopt
bugs		:
bogomips	: 5587.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3840QM CPU @ 2.80GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 1538.359
cache size	: 8192 KB
physical id	: 0
siblings	: 8
core id		: 3
cpu cores	: 4
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 c=
x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave=
 avx f16c rdrand lahf_lm ida arat epb pln pts dtherm tpr_shadow vnmi flexpr=
iority ept vpid fsgsbase smep erms xsaveopt
bugs		:
bogomips	: 5587.03
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=xorg_crash_fedora_21.txt

-- Logs begin at Thu 2015-03-05 21:16:03 CET, end at Thu 2015-03-05 23:24:11 CET. --
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: X.Org X Server 1.16.3
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Release Date: 2014-12-20
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: X Protocol Version 11, Revision 0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Build Operating System:  3.17.8-300.bz1178975.fc21.x86_64
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Current Operating System: Linux localhost.localdomain 3.18.7-200.fc21.x86_64 #1 SMP Wed Feb 11 21:53:17 UTC 2015 x86_64
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.18.7-200.fc21.x86_64 root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root rhgb quiet LANG=en_DK.UTF-8 crashkernel=128M
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Build Date: 31 January 2015  11:23:27PM
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Build ID: xorg-x11-server 1.16.3-2.fc21
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Current version of pixman: 0.32.6
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Before reporting problems, check http://wiki.x.org
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: to make sure that you have the latest version.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Markers: (--) probed, (**) from config file, (==) default setting,
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (++) from command line, (!!) notice, (II) informational,
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (++) Log file: "/dev/null", Time: Thu Mar  5 21:40:07 2015
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Using config directory: "/etc/X11/xorg.conf.d"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Using system config directory "/usr/share/X11/xorg.conf.d"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) No Layout section.  Using the first Screen section.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) No screen section available. Using defaults.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) |-->Screen "Default Screen Section" (0)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) |   |-->Monitor "<default monitor>"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) No monitor specified for screen "Default Screen Section".
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Using a default monitor configuration.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Automatically adding devices
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Automatically enabling devices
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Automatically adding GPU devices
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) FontPath set to:
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: catalogue:/etc/X11/fontpath.d,
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: built-ins
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) ModulePath set to "/usr/lib64/xorg/modules"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) The server relies on udev to provide the list of input devices.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: If no devices become available, reconfigure udev or disable AutoAddDevices.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loader magic: 0x81de40
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module ABI versions:
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: X.Org ANSI C Emulation: 0.4
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: X.Org Video Driver: 18.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: X.Org XInput driver : 21.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: X.Org Server Extension : 8.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (EE) systemd-logind: failed to get session: PID 1295 does not belong to any known session
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) xfree86: Adding drm device (/dev/dri/card0)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) PCI:*(0:0:2:0) 8086:0166:17aa:21f5 rev 9, Mem @ 0xf0000000/4194304, 0xe0000000/268435456, I/O @ 0x00005000/64, BIOS @ 0x????????/131072
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "glx"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading /usr/lib64/xorg/modules/extensions/libglx.so
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module glx: vendor="X.Org Foundation"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: compiled for 1.16.3, module version = 1.0.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: ABI class: X.Org Server Extension, version 8.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) AIGLX enabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Matched intel as autoconfigured driver 0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Matched intel as autoconfigured driver 1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Matched modesetting as autoconfigured driver 2
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Matched fbdev as autoconfigured driver 3
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Matched vesa as autoconfigured driver 4
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Assigned the driver to the xf86ConfigLayout
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "intel"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading /usr/lib64/xorg/modules/drivers/intel_drv.so
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module intel: vendor="X.Org Foundation"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: compiled for 1.16.1, module version = 2.99.916
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Module class: X.Org Video Driver
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: ABI class: X.Org Video Driver, version 18.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "modesetting"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading /usr/lib64/xorg/modules/drivers/modesetting_drv.so
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module modesetting: vendor="X.Org Foundation"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: compiled for 1.16.0, module version = 0.9.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Module class: X.Org Video Driver
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: ABI class: X.Org Video Driver, version 18.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "fbdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading /usr/lib64/xorg/modules/drivers/fbdev_drv.so
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module fbdev: vendor="X.Org Foundation"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: compiled for 1.16.0, module version = 0.4.3
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Module class: X.Org Video Driver
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: ABI class: X.Org Video Driver, version 18.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "vesa"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading /usr/lib64/xorg/modules/drivers/vesa_drv.so
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module vesa: vendor="X.Org Foundation"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: compiled for 1.16.0, module version = 2.3.2
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Module class: X.Org Video Driver
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: ABI class: X.Org Video Driver, version 18.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel: Driver for Intel(R) Integrated Graphics Chipsets:
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: i810, i810-dc100, i810e, i815, i830M, 845G, 854, 852GM/855GM, 865G,
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: 915G, E7221 (i915), 915GM, 945G, 945GM, 945GME, Pineview GM,
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Pineview G, 965G, G35, 965Q, 946GZ, 965GM, 965GME/GLE, G33, Q35, Q33,
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: GM45, 4 Series, G45/G43, Q45/Q43, G41, B43
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel: Driver for Intel(R) HD Graphics: 2000-6000
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel: Driver for Intel(R) Iris(TM) Graphics: 5100, 6100
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel: Driver for Intel(R) Iris(TM) Pro Graphics: 5200, 6200, P6300
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) modesetting: Driver for Modesetting Kernel Drivers: kms
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) FBDEV: driver for framebuffer: fbdev
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) VESA: driver for VESA chipsets: vesa
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (++) using VT number 1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Using Kernel Mode Setting driver: i915, version 1.6.0 20140905
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (WW) Falling back to old probe method for modesetting
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (WW) Falling back to old probe method for fbdev
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading sub module "fbdevhw"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "fbdevhw"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading /usr/lib64/xorg/modules/libfbdevhw.so
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module fbdevhw: vendor="X.Org Foundation"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: compiled for 1.16.3, module version = 0.0.2
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: ABI class: X.Org Video Driver, version 18.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (WW) Falling back to old probe method for vesa
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) intel(0): Integrated Graphics Chipset: Intel(R) HD Graphics 4000
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) intel(0): CPU: x86-64, sse2, sse3, ssse3, sse4.1, sse4.2, avx
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Creating default Display subsection in Screen section
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: "Default Screen Section" for depth/fbbpp 24/32
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): Depth 24, (--) framebuffer bpp 32
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): RGB weight 888
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): Default visual is TrueColor
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Output LVDS1 has no monitor section
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) intel(0): Found backlight control interface intel_backlight (type 'raw') for output LVDS1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Enabled output LVDS1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Output VGA1 has no monitor section
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Enabled output VGA1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) intel(0): Using a maximum size of 256x256 for hardware cursors
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Output VIRTUAL1 has no monitor section
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Enabled output VIRTUAL1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) intel(0): Output LVDS1 using initial mode 1920x1080 on pipe 0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): TearFree disabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): DPI set to (96, 96)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading sub module "dri3"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "dri3"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module "dri3" already built-in
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading sub module "dri2"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "dri2"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module "dri2" already built-in
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading sub module "present"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "present"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module "present" already built-in
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "modesetting"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Unloading modesetting
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "fbdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Unloading fbdev
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadSubModule: "fbdevhw"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Unloading fbdevhw
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "vesa"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Unloading vesa
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) Depth 24 pixmap format is 32 bpp
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): SNA initialized with Ivybridge (gen7, gt2) backend
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): Backing store enabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): Silken mouse enabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): HW Cursor enabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): RandR 1.2 enabled, ignore the following RandR disabled message.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): DPMS enabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (==) intel(0): display hotplug detection enabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): [DRI2] Setup complete
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): [DRI2]   DRI driver: i965
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): [DRI2]   VDPAU driver: i965
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): direct rendering: DRI2 DRI3 enabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): hardware support for Present enabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) RandR disabled
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) SELinux: Disabled by boolean
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_MESA_copy_sub_buffer
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_ARB_create_context
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_ARB_create_context_profile
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_EXT_create_context_es2_profile
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_INTEL_swap_event
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_SGI_swap_control and GLX_MESA_swap_control
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_EXT_framebuffer_sRGB
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_ARB_fbconfig_float
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: GLX_EXT_texture_from_pixmap backed by buffer objects
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: enabled GLX_ARB_create_context_robustness
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) AIGLX: Loaded and initialized i965
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) GLX: Initialized DRI2 GL provider for screen 0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): switch to mode 1920x1080@60.0 on LVDS1 using pipe 0, position (0, 0), rotation normal, reflection none
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Setting screen physical size to 508 x 285
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device Power Button (/dev/input/event2)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Power Button: Applying InputClass "evdev keyboard catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Power Button: Applying InputClass "system-keyboard"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "evdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading /usr/lib64/xorg/modules/input/evdev_drv.so
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module evdev: vendor="X.Org Foundation"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: compiled for 1.16.0, module version = 2.9.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Module class: X.Org XInput Driver
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: ABI class: X.Org XInput driver, version 21.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Using input driver 'evdev' for 'Power Button'
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Power Button: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: Power Button: Device: "/dev/input/event2"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: Power Button: Vendor 0 Product 0x1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: Power Button: Found keys
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: Power Button: Configuring as keyboard
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2/event2"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) XINPUT: Adding extended input device "Power Button" (type: KEYBOARD, id 6)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_rules" "evdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_model" "pc104"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_layout" "dk"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: The XKEYBOARD keymap compiler (xkbcomp) reports:
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: > Warning:          Type "ONE_LEVEL" has 1 levels, but <RALT> has 2 symbols
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: >                   Ignoring extra symbols
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Errors from xkbcomp are not fatal to the X server
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device Video Bus (/dev/input/event5)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Video Bus: Applying InputClass "evdev keyboard catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Video Bus: Applying InputClass "system-keyboard"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Using input driver 'evdev' for 'Video Bus'
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Video Bus: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: Video Bus: Device: "/dev/input/event5"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: Video Bus: Vendor 0 Product 0x6
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: Video Bus: Found keys
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: Video Bus: Configuring as keyboard
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7/event5"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) XINPUT: Adding extended input device "Video Bus" (type: KEYBOARD, id 7)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_rules" "evdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_model" "pc104"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_layout" "dk"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device Lid Switch (/dev/input/event0)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) No input driver specified, ignoring this device.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) This device may have been added with another device file.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device Sleep Button (/dev/input/event1)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Sleep Button: Applying InputClass "evdev keyboard catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Sleep Button: Applying InputClass "system-keyboard"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Using input driver 'evdev' for 'Sleep Button'
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Sleep Button: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: Sleep Button: Device: "/dev/input/event1"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: Sleep Button: Vendor 0 Product 0x3
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: Sleep Button: Found keys
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: Sleep Button: Configuring as keyboard
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1/event1"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) XINPUT: Adding extended input device "Sleep Button" (type: KEYBOARD, id 8)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_rules" "evdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_model" "pc104"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_layout" "dk"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device Integrated Camera (/dev/input/event12)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Integrated Camera: Applying InputClass "evdev keyboard catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Integrated Camera: Applying InputClass "system-keyboard"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Using input driver 'evdev' for 'Integrated Camera'
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Integrated Camera: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: Integrated Camera: Device: "/dev/input/event12"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: Integrated Camera: Vendor 0x5986 Product 0x2d2
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: Integrated Camera: Found keys
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: Integrated Camera: Configuring as keyboard
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.6/3-1.6:1.0/input/input13/event12"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) XINPUT: Adding extended input device "Integrated Camera" (type: KEYBOARD, id 9)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_rules" "evdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_model" "pc104"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_layout" "dk"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device HDA Intel PCH Dock Mic (/dev/input/event9)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) No input driver specified, ignoring this device.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) This device may have been added with another device file.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device HDA Intel PCH Headphone (/dev/input/event10)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) No input driver specified, ignoring this device.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) This device may have been added with another device file.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device HDA Intel PCH Dock Headphone (/dev/input/event11)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) No input driver specified, ignoring this device.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) This device may have been added with another device file.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device HDA Intel PCH Mic (/dev/input/event8)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) No input driver specified, ignoring this device.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) This device may have been added with another device file.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device AT Translated Set 2 keyboard (/dev/input/event3)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) AT Translated Set 2 keyboard: Applying InputClass "evdev keyboard catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) AT Translated Set 2 keyboard: Applying InputClass "system-keyboard"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Using input driver 'evdev' for 'AT Translated Set 2 keyboard'
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) AT Translated Set 2 keyboard: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: AT Translated Set 2 keyboard: Device: "/dev/input/event3"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: AT Translated Set 2 keyboard: Vendor 0x1 Product 0x1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: AT Translated Set 2 keyboard: Found keys
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: AT Translated Set 2 keyboard: Configuring as keyboard
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "config_info" "udev:/sys/devices/platform/i8042/serio0/input/input3/event3"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) XINPUT: Adding extended input device "AT Translated Set 2 keyboard" (type: KEYBOARD, id 10)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_rules" "evdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_model" "pc104"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_layout" "dk"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/event4)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: Applying InputClass "evdev touchpad catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: Applying InputClass "touchpad catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: Applying InputClass "Default clickpad buttons"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) LoadModule: "synaptics"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Loading /usr/lib64/xorg/modules/input/synaptics_drv.so
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Module synaptics: vendor="X.Org Foundation"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: compiled for 1.16.3, module version = 1.8.1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: Module class: X.Org XInput Driver
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: ABI class: X.Org XInput driver, version 21.0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Using input driver 'synaptics' for 'SynPS/2 Synaptics TouchPad'
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "Device" "/dev/input/event4"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) synaptics: SynPS/2 Synaptics TouchPad: ignoring touch events for semi-multitouch device
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) synaptics: SynPS/2 Synaptics TouchPad: x-axis range 1472 - 5470 (res 60)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) synaptics: SynPS/2 Synaptics TouchPad: y-axis range 1408 - 4498 (res 85)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) synaptics: SynPS/2 Synaptics TouchPad: pressure range 0 - 255
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) synaptics: SynPS/2 Synaptics TouchPad: finger width range 0 - 15
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) synaptics: SynPS/2 Synaptics TouchPad: buttons: left right double triple
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) synaptics: SynPS/2 Synaptics TouchPad: Vendor 0x2 Product 0x7
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "config_info" "udev:/sys/devices/platform/i8042/serio1/input/input5/event4"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) XINPUT: Adding extended input device "SynPS/2 Synaptics TouchPad" (type: TOUCHPAD, id 11)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) MinSpeed is now constant deceleration 2.5
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) MaxSpeed is now 1.75
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) synaptics: SynPS/2 Synaptics TouchPad: (accel) AccelFactor is now 0.040
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: (accel) keeping acceleration scheme 1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: (accel) acceleration profile 1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: (accel) acceleration factor: 2.000
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) SynPS/2 Synaptics TouchPad: (accel) acceleration threshold: 4
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/mouse0)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) No input driver specified, ignoring this device.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) This device may have been added with another device file.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device TPPS/2 IBM TrackPoint (/dev/input/event6)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) TPPS/2 IBM TrackPoint: Applying InputClass "evdev pointer catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Using input driver 'evdev' for 'TPPS/2 IBM TrackPoint'
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) TPPS/2 IBM TrackPoint: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: TPPS/2 IBM TrackPoint: Device: "/dev/input/event6"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: TPPS/2 IBM TrackPoint: Vendor 0x2 Product 0xa
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: TPPS/2 IBM TrackPoint: Found 3 mouse buttons
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: TPPS/2 IBM TrackPoint: Found relative axes
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: TPPS/2 IBM TrackPoint: Found x and y relative axes
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: TPPS/2 IBM TrackPoint: Configuring as mouse
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: TPPS/2 IBM TrackPoint: YAxisMapping: buttons 4 and 5
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: TPPS/2 IBM TrackPoint: EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "config_info" "udev:/sys/devices/platform/i8042/serio1/serio2/input/input6/event6"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) XINPUT: Adding extended input device "TPPS/2 IBM TrackPoint" (type: MOUSE, id 12)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: TPPS/2 IBM TrackPoint: initialized for relative axes.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) TPPS/2 IBM TrackPoint: (accel) keeping acceleration scheme 1
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) TPPS/2 IBM TrackPoint: (accel) acceleration profile 0
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) TPPS/2 IBM TrackPoint: (accel) acceleration factor: 2.000
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) TPPS/2 IBM TrackPoint: (accel) acceleration threshold: 4
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device TPPS/2 IBM TrackPoint (/dev/input/mouse1)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) No input driver specified, ignoring this device.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) This device may have been added with another device file.
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) config/udev: Adding input device ThinkPad Extra Buttons (/dev/input/event7)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) ThinkPad Extra Buttons: Applying InputClass "evdev keyboard catchall"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) ThinkPad Extra Buttons: Applying InputClass "system-keyboard"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) Using input driver 'evdev' for 'ThinkPad Extra Buttons'
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) ThinkPad Extra Buttons: always reports core events
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) evdev: ThinkPad Extra Buttons: Device: "/dev/input/event7"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: ThinkPad Extra Buttons: Vendor 0x17aa Product 0x5054
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (--) evdev: ThinkPad Extra Buttons: Found keys
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: ThinkPad Extra Buttons: Configuring as keyboard
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "config_info" "udev:/sys/devices/platform/thinkpad_acpi/input/input8/event7"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (II) XINPUT: Adding extended input device "ThinkPad Extra Buttons" (type: KEYBOARD, id 13)
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_rules" "evdev"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_model" "pc104"
Mar 05 21:40:07 localhost.localdomain gdm-Xorg-:0[1295]: (**) Option "xkb_layout" "dk"
Mar 05 21:40:08 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): EDID vendor "LEN", prod id 16562
Mar 05 21:40:08 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Printing DDC gathered Modelines:
Mar 05 21:40:08 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Modeline "1920x1080"x0.0  139.00  1920 1980 2028 2050  1080 1090 1100 1130 -hsync -vsync (67.8 kHz eP)
Mar 05 21:40:08 localhost.localdomain gdm-Xorg-:0[1295]: (II) intel(0): Modeline "1920x1080"x0.0  115.83  1920 1980 2028 2050  1080 1090 1100 1130 -hsync -vsync (56.5 kHz e)
Mar 05 21:40:08 localhost.localdomain gdm-Xorg-:0[1295]: The XKEYBOARD keymap compiler (xkbcomp) reports:
Mar 05 21:40:08 localhost.localdomain gdm-Xorg-:0[1295]: > Warning:          Type "ONE_LEVEL" has 1 levels, but <RALT> has 2 symbols
Mar 05 21:40:08 localhost.localdomain gdm-Xorg-:0[1295]: >                   Ignoring extra symbols
Mar 05 21:40:08 localhost.localdomain gdm-Xorg-:0[1295]: Errors from xkbcomp are not fatal to the X server
Mar 05 21:40:09 localhost.localdomain gdm-Xorg-:0[1295]: The XKEYBOARD keymap compiler (xkbcomp) reports:
Mar 05 21:40:09 localhost.localdomain gdm-Xorg-:0[1295]: > Warning:          Type "ONE_LEVEL" has 1 levels, but <RALT> has 2 symbols
Mar 05 21:40:09 localhost.localdomain gdm-Xorg-:0[1295]: >                   Ignoring extra symbols
Mar 05 21:40:09 localhost.localdomain gdm-Xorg-:0[1295]: Errors from xkbcomp are not fatal to the X server
Mar 05 21:40:59 localhost.localdomain gdm-Xorg-:0[1295]: The XKEYBOARD keymap compiler (xkbcomp) reports:
Mar 05 21:40:59 localhost.localdomain gdm-Xorg-:0[1295]: > Warning:          Type "ONE_LEVEL" has 1 levels, but <RALT> has 2 symbols
Mar 05 21:40:59 localhost.localdomain gdm-Xorg-:0[1295]: >                   Ignoring extra symbols
Mar 05 21:40:59 localhost.localdomain gdm-Xorg-:0[1295]: Errors from xkbcomp are not fatal to the X server
Mar 05 21:41:00 localhost.localdomain gdm-Xorg-:0[1295]: The XKEYBOARD keymap compiler (xkbcomp) reports:
Mar 05 21:41:00 localhost.localdomain gdm-Xorg-:0[1295]: > Warning:          Type "ONE_LEVEL" has 1 levels, but <RALT> has 2 symbols
Mar 05 21:41:00 localhost.localdomain gdm-Xorg-:0[1295]: >                   Ignoring extra symbols
Mar 05 21:41:00 localhost.localdomain gdm-Xorg-:0[1295]: Errors from xkbcomp are not fatal to the X server
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: ThinkPad Extra Buttons: Close
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "evdev"
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: TPPS/2 IBM TrackPoint: Close
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "evdev"
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: AT Translated Set 2 keyboard: Close
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "evdev"
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: Integrated Camera: Close
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "evdev"
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: Sleep Button: Close
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "evdev"
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: Video Bus: Close
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "evdev"
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) evdev: Power Button: Close
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "evdev"
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (II) UnloadModule: "synaptics"
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE)
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) Backtrace:
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 0: /usr/libexec/Xorg.bin (OsLookupColor+0x119) [0x59c739]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 1: /lib64/libc.so.6 (__restore_rt+0x0) [0x7f39700e595f]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 2: /usr/libexec/Xorg.bin (present_extension_init+0x11c) [0x51970c]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 3: /usr/libexec/Xorg.bin (present_extension_init+0x53c) [0x519f0c]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 4: /usr/libexec/Xorg.bin (PanoramiXRenderReset+0x21a3) [0x51b0d3]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 5: /usr/libexec/Xorg.bin (CompositeRegisterImplicitRedirectionException+0x3f58) [0x4d1178]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 6: /usr/libexec/Xorg.bin (PanoramiXRenderReset+0x854) [0x517dc4]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 7: /usr/libexec/Xorg.bin (remove_fs_handlers+0x527) [0x43d427]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 8: /lib64/libc.so.6 (__libc_start_main+0xf0) [0x7f39700d0fe0]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 9: /usr/libexec/Xorg.bin (_start+0x29) [0x4276ee]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) 10: ? (?+0x29) [0x29]
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE)
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) Segmentation fault at address 0x10
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE)
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: Fatal server error:
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) Caught signal 11 (Segmentation fault). Server aborting
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE)
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE)
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: Please consult the Fedora Project support
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: at http://wiki.x.org
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: for help.
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE) Please also check the log file at "/dev/null" for additional information.
Mar 05 21:54:33 localhost.localdomain gdm-Xorg-:0[1295]: (EE)

--=-=-=--
