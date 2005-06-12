From: Jonathan Buzzard <jonathan@buzzard.me.uk>
Subject: [tlinux-users:07062] Re: plans for toshiba_acpi
Date: Sun, 12 Jun 2005 20:46:54 +0100
Message-ID: <E1DhYQ2-0003OC-Rm@grumpy.buzzard.me.uk>
References: <42AC42E1.50801@neggie.net>
Reply-To: tlinux-users@linux.toshiba-dme.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <tlinux-users-admin@linux.toshiba-dme.co.jp>
In-Reply-To: <42AC42E1.50801@neggie.net> 
List-Software: fml [fml 4.0 STABLE (20021020/4.0.4_ALPHA)]
List-Post: <mailto:tlinux-users@linux.toshiba-dme.co.jp>
List-Owner: <mailto:tlinux-users-admin@linux.toshiba-dme.co.jp>
List-Help: <mailto:tlinux-users-ctl@linux.toshiba-dme.co.jp?body=help>
List-Unsubscribe: <mailto:tlinux-users-ctl@linux.toshiba-dme.co.jp?body=unsubscribe>
To: John Belmonte <john@neggie.net>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>, Charles Schwieters <charles@schwieters.org>, Timo Hoenig <thoenig@nouse.net>, Daniel Silverstone <dsilvers@digital-scurf.org>, tlinux-users@linux.toshiba-dme.co.jp
List-Id: linux-acpi@vger.kernel.org


john@neggie.net said:
> * incorporate /dev/toshiba emulation patch developed by Gintautas Miliauskas
> and Charles Schwieters.  Available as a run-time option, this causes
> toshiba_acpi to implement the "toshiba" driver's /dev/toshiba interface
> (except for hotkey status).  This device provides access to the Toshiba HCI,
> which can be employed by userspace tools such as "toshset" to adjust a
> laptop's internal Bluetooth device, display, fan, etc.  This patch has been
> in use since early 2004 by several users. Regarding module auto-loading, OS's
> will have to resolve the ambiguity of which driver to load (toshiba or
> toshiba_acpi) when /dev/toshiba is accessed. 

Is it not possible to have a combined kernel module that can determine whether
the ACPI subsystem is running or not and fall back to the old style system if
it is not. The only messy bit I see here is that you would need some #ifdef's
to cater for when ACPI is not enabled for a 

I have no particular desire to perpetuate the toshiba kernel driver as it is
now, and it has always been my long term goal to do this. It has only been
held up due to problems in running a 2.6 kernel on my laptop. The system is
entirely hosted with LVM and XFS and early attempts at getting it working where
unsucessful.

If someone else with the time wishes to merge the two Toshiba drivers far be
it for me to stand in their way.


JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan (at) buzzard.me.uk
Northumberland, United Kingdom.       Tel: +44 1661-832195
