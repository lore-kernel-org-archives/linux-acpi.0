From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] properly create kobjects in acpi/scan.c
Date: 24 Aug 2004 15:50:44 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093377043.18588.268.camel@dhcppc4>
References: <200408240134.16962.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0aV3qh4uuSkotP1AOwjU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408240134.16962.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-0aV3qh4uuSkotP1AOwjU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-08-24 at 02:34, Dmitry Torokhov wrote:
> Hi,
> 
> I have a bunch of patches that I would like you to take a look at:
> 
> 01-acpi-scan-kobject.patch
> 	- properly create/register kobjects - take reference to the parent
> 	  since kobject_unregister will try dropping it potentially
> 	  (if ACPI was ever to release created devices) causing parent be
> 	  destroyed early) and use kobject_set_name to properly set name.

I'll take a look.

> 02-acpi-event-code.patch
> 	- move event (userspace signalling) code from acpi/bus.c to
>           acpi/event.c as too many implementation details were exported,
> 	  plus some additional fixes to the event handling code.

I'll take a look.

> 03-acpi-use-rwsem.patch
> 	- kill brandead usage of acpi_device_lock & list_for_eacj_safe.
> 	  list_for_each_safe is only safe in the sense that current
> 	  element can be safely removed by the same thread that is using
> 	  list_for_each_safe. List still has to be protected from other
> 	  threads for entire duration of list traversal.
> 	  Use acpi_subsys.rwsem instead of acpi_device_lock to protect
> 	  lists.

sounds like a bug.

> Btw, why don't we just convert ACPI to be standard driver core bus with
> standard drivers and devices? I could cook up something... The
> /sys/firmware/acpi hierarchy is not populated with any useful data yet
> so there should be no concern of breakign userspace interface (I am mot
> talking about removing /proc/acpi part at the moment).

Funny you should mention it.

My current opinion is that /sys/firmware/acpi should probably
not exist at all, and that there should be a single
/sys/devices including both ACPI-enumerated and pci-enumerated
devices.  Adam and I have been ganging up on Patrick on this,
but we don't have him convinced yet...

> 04-acpi-multiple-readers.patch
> 	- allow multiple readrs access /proc/acpi/event, every event is
> 	  delivered to all readers. Also limit number of pending events
> 	  to 64 (per reader) so if reader is stuck ACPI does not consume
> 	  all memory.
> 
> 	  Can be user by various daemons, I could see cpufreqd listening
> 	  for battery insertion/removal events and debugging is much
> 	  easier too.

others have been frustrated by this also, so I tend to agree that
we should probably address it.  Somebody can still contact acpid if they
want to...  At some point, of course, we're going to have to move this
out of /proc...

> The patches are against last night pull from Linus repo.

Note that if you did individual file comments, then I can preserve your
comments if you export with bjorn's bkexport script (attached).

thanks,
-Len




--=-0aV3qh4uuSkotP1AOwjU
Content-Disposition: attachment; filename=bkimport
Content-Type: text/plain; name=bkimport; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/sh

# Import a bitkeeper patch, preserving author and per-file comments

_import() {
    PATCH=$1

    FROM=`grep '^#### AUTHOR' $PATCH`
    export BK_USER=`echo $FROM | sed -e 's/^#### AUTHOR //' -e 's/@.*//'`
    export BK_HOST=`echo $FROM | sed -e 's/.*@//'`

    echo Importing $PATCH from $BK_USER@$BK_HOST

    #bk import -tpatch -qR $PATCH .
    bk import -tpatch -vR $PATCH .
    if [ $? -ne 0 ]; then
	echo $PATCH: import failed
	exit 0
    fi
    cat $PATCH |\
	awk "/#### COMMENT START/ {p=1; next}; /#### COMMENT END/ {exit}; p==1" |\
	bk comments -
}

for P in $@; do
    _import $P
done

--=-0aV3qh4uuSkotP1AOwjU
Content-Disposition: attachment; filename=bkexport
Content-Type: text/plain; name=bkexport; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/sh

# Export a bitkeeper patch, adding author and per-file comments

if [ $# -gt 1 ]; then
	CSET=`bk r2c $*`
	CSET="-r$CSET"
else
	CSET=$1
fi

echo -n "#### AUTHOR "
bk cset $CSET |\
    awk -F\| "{printf \"bk prs -r%s -h -d '\$if(:DPN:=ChangeSet){:USER:@:HOST:\\n}' %s\n\", \$2, \$1}" |\
    sh
echo "#### COMMENT START"
bk cset $CSET |\
    awk -F\| "{printf \"bk prs -r%s -h -d '### Comments for :DPN:\\n\$each(:C:){(:C:)\\n}' %s\n\", \$2, \$1}" |\
    sh
echo "#### COMMENT END"
echo

bk export -tpatch -du $CSET

--=-0aV3qh4uuSkotP1AOwjU--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
