From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCHv2 0/2] Introducing the Ambient Light Sensor (ALS) class
Date: Mon, 7 Dec 2009 16:50:23 +0200
Message-ID: <37786d4b0912070650g7ba7604bv63365a21f980501d@mail.gmail.com>
References: <1259581514-15356-1-git-send-email-amit.kucheria@verdurent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932710AbZLGOuX@vger.kernel.org>
In-Reply-To: <1259581514-15356-1-git-send-email-amit.kucheria@verdurent.com>
Sender: linux-kernel-owner@vger.kernel.org
To: List Linux Kernel <linux-kernel@vger.kernel.org>
Cc: rui.zhang@intel.com, jic23@cam.ac.uk, khali@linux-fr.org, alan@linux.intel.com, linux-acpi@vger.kernel.org, gregkh@suse.de, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 30, 2009 at 1:45 PM, Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
> Introduce a new class of devices to handle ambient light sensors. Cur=
rently
> only one sysfs inteface, 'illuminance' is introduced. More will be ad=
ded as
> drivers are ported to use this new class.
>
> Amit Kucheria (1):
> =A0als: add unique device-ids to the als device class
>
> Zhang Rui (1):
> =A0introduce ALS sysfs class
>
> =A0Documentation/ABI/testing/sysfs-class-als | =A0 =A09 ++
> =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A06 ++
> =A0drivers/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +
> =A0drivers/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
> =A0drivers/als/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 10 +++
> =A0drivers/als/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A05 +
> =A0drivers/als/als_sys.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
116 +++++++++++++++++++++++++++++
> =A0include/linux/als_sys.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
35 +++++++++
> =A08 files changed, 184 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/ABI/testing/sysfs-class-als
> =A0create mode 100644 drivers/als/Kconfig
> =A0create mode 100644 drivers/als/Makefile
> =A0create mode 100644 drivers/als/als_sys.c
> =A0create mode 100644 include/linux/als_sys.h
>

(Bump)

Is there any blocker to adding this for 2.6.33? Which maintainer will
pick up the ALS framework?

Rui, do you have an updated patch for the ACPI ALS driver?

Regards,
Amit
