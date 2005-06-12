From: John Belmonte <john@neggie.net>
Subject: [tlinux-users:07059] plans for toshiba_acpi
Date: Sun, 12 Jun 2005 10:12:49 -0400
Message-ID: <42AC42E1.50801@neggie.net>
Reply-To: tlinux-users@linux.toshiba-dme.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <tlinux-users-admin@linux.toshiba-dme.co.jp>
List-Software: fml [fml 4.0 STABLE (20021020/4.0.4_ALPHA)]
List-Post: <mailto:tlinux-users@linux.toshiba-dme.co.jp>
List-Owner: <mailto:tlinux-users-admin@linux.toshiba-dme.co.jp>
List-Help: <mailto:tlinux-users-ctl@linux.toshiba-dme.co.jp?body=help>
List-Unsubscribe: <mailto:tlinux-users-ctl@linux.toshiba-dme.co.jp?body=unsubscribe>
To: acpi-devel <acpi-devel@lists.sourceforge.net>
Cc: Charles Schwieters <charles@schwieters.org>, Timo Hoenig <thoenig@nouse.net>, Daniel Silverstone <dsilvers@digital-scurf.org>, Jonathan Buzzard <jonathan@buzzard.org.uk>, tlinux-users@linux.toshiba-dme.co.jp
List-Id: linux-acpi@vger.kernel.org

Here are my plans for enhancing the "toshiba_acpi" driver, and imploding
the "/proc/acpi/toshiba" interface.

* incorporate ACPI hotkeys patch developed by Daniel Silverstone and
used in Ubuntu Linux.  Available as a run-time option, this creates a
kernel thread which polls the Toshiba firmware for hotkey events, and
passes them along to the ACPI subsystem.

* incorporate /dev/toshiba emulation patch developed by Gintautas
Miliauskas and Charles Schwieters.  Available as a run-time option, this
causes toshiba_acpi to implement the "toshiba" driver's /dev/toshiba
interface (except for hotkey status).  This device provides access to
the Toshiba HCI, which can be employed by userspace tools such as
"toshset" to adjust a laptop's internal Bluetooth device, display, fan,
etc.  This patch has been in use since early 2004 by several users.
Regarding module auto-loading, OS's will have to resolve the ambiguity
of which driver to load (toshiba or toshiba_acpi) when /dev/toshiba is
accessed.

* add run-time option to suppress creation of /proc/acpi/toshiba.  Since
 the above two options cover the existing /proc/acpi/toshiba interface
and more, the proc interface can be disabled once userspace tools catch up.

Please follow up on <acpi-devel@lists.sourceforge.net>.

--John
