From: Jean-Michel POURE <jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org>
Subject: Re: power-off problem : ASUS K7 + ASUS L3800 + Kernel 2.6-pre9
Date: Wed, 17 Dec 2003 14:09:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312171409.06540.jm.poure@freesurf.fr>
References: <Pine.GHP.4.44.0312171156130.27308-100000@elektron.its.tudelft.nl>
Reply-To: jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.GHP.4.44.0312171156130.27308-100000-1JbLm1bU5j7YjFCvLzxXUyvJykC1LJ6w@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org, Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Le Mercredi 17 D=E9cembre 2003 12:08, Arjen Verweij a =E9crit :
> I heard that with powerdown trouble, can possibly be solved by using
> userland deamons, like apmd for apm and acpid for acpi. I will try the
> acpid for my laptop during the holidays.

Sorry, I misread your message. The ACPI deamon loads the required ACPI=20
modules. What alse can it do? IMHO, the problem does not lay here.

Cheers, Jean-Michel

*************
#! /bin/sh -e

test -x /usr/sbin/acpid || exit 0

# Include acpid defaults if available
OPTIONS=3D""
if [ -f /etc/default/acpid ] ; then
        . /etc/default/acpid
fi

# As the name says. If the kernel supports modules, it'll try to load
# the ones listed in "MODULES".
load_modules() {
        LIST=3D`/sbin/lsmod|awk '!/Module/ {print $1}'`

        if [ "$MODULES" =3D "all" ]; then
                LOC=3D"/lib/modules/`uname -r`/kernel/drivers/acpi"
                if [ -d $LOC ]; then
                  MODULES=3D`( find $LOC -type f -name "*.o" -printf "basen=
ame %
f .o\n"; \
                        find $LOC -type f -name "*.ko" -printf "basename %
f .ko\n" ) | /bin/sh`
                else
                  MODULES=3D""
                fi
        fi

        for mod in $MODULES; do
                echo $LIST | grep -q -w "$mod" || modprobe $mod || /bin/true
        done
}

case "$1" in
  start)
    echo -n "Starting Advanced Configuration and Power Interface daemon: "
    [ -f /proc/modules ] && load_modules
    if [ ! -d /proc/acpi ]; then
        echo "not supported by kernel"
        exit 0
    fi
    start-stop-daemon --start --quiet --exec /usr/sbin/acpid -- -c /etc/acp=
i/
events $OPTIONS
    echo "acpid."
    ;;
  stop)
    echo -n "Stopping Advanced Configuration and Power Interface daemon: "
    start-stop-daemon --stop --quiet --oknodo --exec /usr/sbin/acpid
    echo "acpid."
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  reload|force-reload)
    echo "Reloading Advanced Configuration and Power Interface daemon=20
configuration files"
    start-stop-daemon --stop --signal 1 --exec /usr/sbin/acpid
    ;;
  *)
    echo "Usage: /etc/init.d/acpid {start|stop|restart|reload|force-reload}"
    exit 1
esac



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
