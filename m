From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Determining Button State
Date: 08 Dec 2002 00:19:12 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039324752.3240.6.camel@sirius.strandboge.cxm>
References: <3DF2D221.7020005@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DF2D221.7020005-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2002-12-08 at 00:01, Matthew Tippett wrote:
> Hello,
> 
> Looking at rolling out some sort of ACPI script environment for acpid. 
> Is there any way that the ACPI system determines exposes what state the 
> subsystem is in.
> 
> When I close the lid on my laptop, I get the event -
> 
> button/lid LID 00000080 0000000b
> button/lid LID 00000080 0000000c
> button/lid LID 00000080 0000000d
> button/lid LID 00000080 0000000e
> button/lid LID 00000080 0000000f
> 
> Which doesn't seem to have anything that indicates 'down or up'.  I 
> understand an 'up/down' doesn't make sense for Power or Sleep, but it 
> seems pretty vital to something like a lid.

Nope, and you can't use odd or even either because it changes.  I did
this:

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

                        # go to X now
                        /usr/bin/chvt 7         
         
                        # restore the keyboard
                        /sbin/kbdrate -r 30 -d 250 < /dev/console
                else
                        logger -p daemon.info "ACPI lid: lid is closed"
                        touch $CLOSEDFILE

                        # go to a tty1 first
                        /usr/bin/chvt 1         
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



This however assumes that the lid is open when I power on (not an
unreasonable assumption usually, since I can't press the power button
otherwise).  I chose /var/run since it is cleaned out automatically.

Jamie Strandboge

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
