From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: lid state?
Date: 07 Oct 2002 14:15:15 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034014515.632.2.camel@sirius.strandboge.cxm>
References: <3D9FC692.6050005@prairienet.org>
	<OE13CngokVNTmgEVg3U0000c5a1@hotmail.com>
	<E17yYmP-0004wp-00@noys.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E17yYmP-0004wp-00-Hkr6DilkjYZTIIw02KIYYwp9XTrnmqkB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2002-10-07 at 10:22, Frank Mehnert wrote:
> On Monday 07 October 2002 14:10, Derek Broughton wrote:
> > From: "John Belmonte" <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
> >
> > > What is the correct way to detect the lid state on a lid event?  I've
> > > seen some mention of using a counter, but as the lid could be closed
> > > before acpid starts up, it doesn't seem very robust.
> >
> > It's far from ideal, but it's robust enough, because the lid state bears no
> > connection to acpid.  Whether or not acpid is running, events get
> > generated. I suppose, conceivably, the lid could be closed when the system
> > boots and ACPI starts - but how realistic is that?  I can't see it
> > happening on my system.
> 
> Very realistic if you have attached an external monitor to your notebook.
> 
This would be nice, but as a workaround/solution, I use touch in my
lid.sh script.  Eg:

#!/bin/sh
CLOSEDFILE="/var/run/acpi_lid_closed"

case "$2" in
    LID)
        case "$3" in
            00000080)
                if [ -e "$CLOSEDFILE" ];
                then
                        logger -p daemon.info "ACPI lid: lid is open"
                        rm -f $CLOSEDFILE
                else
                        logger -p daemon.info "ACPI lid: lid is closed"
                        touch $CLOSEDFILE
                fi
                ;;                      
            *)
                logger -p daemon.info "ACPI lid: unknown event $3 (in
$@)"
                ;;
        esac
        ;;
    *)
        logger -p daemon.info "ACPI lid: unknown event $2 (in $@)"
        ;;
esac



Since (on my system) /var/run is cleaned out on boot, this works fine. 
Of course, if the lid is closed when the machine comes on, this is
backwards, but I can't turn my laptop on when the lid is closed, so no
big deal for me.  The script could also check if an external monitor was
connected, etc to make sure that it works in whatever situation.

Jamie Strandboge



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
