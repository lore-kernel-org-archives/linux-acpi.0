From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: ACPI patches updated (20021205)
Date: Sat, 7 Dec 2002 00:30:51 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0212070018270.997-100000@phoenix.kerstin.at>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Dec 6, Grover, Andrew <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Fixed a problem where a store to a String or Buffer object
> could cause corruption of the DSDT if the object type being
> stored was the same as the target object type and the length
> of the object being stored was equal to or smaller than the
> original (existing) target object.  This was seen to cause
> corruption of battery _BIF buffers if the _BIF method modified
> the buffer on the fly.
I tried the latest patch, but
a) quering the battery info still takes about 0.6 sec
b) quering the battery state still takes about 0.1 sec
I don't know if your fix should be related, though.
You can get my dsdt from
http://markus.gaugusch.at/dsdt-sony_vaio_fx405.gz
And a dmesg:
http://markus.gaugusch.at/dmesg-2.4.20-acpi2002-12-05-sony_vaio_fx405.txt
If you want, I can add some debug statements (but I forgot their names and
where to place them :-(

The battery information should also contain the model name of the battery,
but it doesn't:

cat /proc/acpi/battery/BAT1/info
present:                 yes
design capacity:         25160 mWh
last full capacity:      25160 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 400 mWh
design capacity low:     384 mWh
capacity granularity 1:  64 mWh
capacity granularity 2:  64 mWh
model number:            5
serial number:           2
battery type:            4 <-- Li-Ion?
OEM info:                5 <-- should be BP1N or something.

I guess, some corruption is still there.

keep up the good work!
Markus

-- 
_____________________________     /"\
Markus Gaugusch  ICQ 11374583     \ /    ASCII Ribbon Campaign
markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org                 X     Against HTML Mail
                                  / \
Linux 2.4.19-4GB * Now playing Stereomud - 2 - Leave



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
