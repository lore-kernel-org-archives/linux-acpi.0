From: Stephan Krings <stephan-MC3rjLPHZ0jJ0Y7HFzmx4Q@public.gmane.org>
Subject: Re: Compaq evo n800v
Date: Mon, 10 Mar 2003 10:19:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15980.22695.764082.140067@hotzenplotz.chateau-neukoelln.de>
References: <1047125223.5077.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1047125223.5077.28.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Anders Persson <anders.persson-sT6loi8rTDSci/EUP2OQSw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

> 2.4.20 kernel +
> patch-2.4.21-pre4.gz +
> acpi-20030218-2.4.21-pre4.diff.gz +
> linux-2.4.18-acpi-20020709-dsdt.patch +
> custom dsdt

I'm also using 2.4.20 but with a slightly older ACPI-patch.

> AC- and battery-status works just fine, as well as the Fn-combinations
> for screen-brightness.

Same for me, although the Fn-keys for changing the display brightness
no longer work, when DRI is enabled in XFree86. But I guess this has
nothing to do with ACPI but is a problem with the XFree86 driver for
Radeon cards.

> But no matter how low the CPU-load, the clock frequency is always at
> max.

I have the same problem. I already wrote about this problem some weeks
ago but got no answer up to now. The funny thing is that toggling the
frequency does indeed work (You can recognize that if you're running a
very CPU intensive task. It'll run slightly slower), but ACPI does not
detect the change.

I didn't really care much about this problem because the notebook just
seems to do the right thing: It'll automatically switch to a lower CPU
frequency when offline and reenable it again once power is online
again. Seems the BIOS is managing this.

> Also, the fan(s?) are always on making noise (at relatively low
> speed but still too high compared to under Win-XPP).

I also see this behaviour. Although the fan is reported to be off (all
fan states in /proc/acpi/fan/*/state say so), it runs at low speed.

I'm using a little hack in one of my startup-scripts to circumvent
this problem. The following shell function will check if the fan is
reported to be off. If it is, it will enforce this for all 4 states
switching the fan on and turning it off immediatly. Works fine for me.

# Make sure the fan is really off, if the ACPI system reports so.
function check_fan () {
    local fan_on="no"
    local i

    for i in /proc/acpi/fan/*/state; do
	grep -q 'status: *on$' $i
	if [ $? = 0 ]; then
	    fan_on="yes"
	    break
	fi
    done

    if [ $fan_on == "no" ]; then
	for i in /proc/acpi/fan/*/state; do
	    echo 0 > $i
	    echo 3 > $i
	done
    fi
}

> I am not really familiar with how this is supposed to work. Can I force
> the CPU to run on the low clock-frequency when, e.g., running on
> batteries?

It does so already, as I noted above. Try it out: Use a CPU intensive
tool which reports its progress and speed (I used transcode for that)
and you'll notice, that it'll run slower once you pull the plug.

You can also notice this by looking at the CPU temperature. It'll
decrease heavily when going offline from power.

It would still be nice to to able to control this manually, I think.

> Can I set load-thresholds when the speed-step functionality
> should take action? Grateful for any help on this!

Should be possible by writing a small monitoring daemon. But since
manually toggling the CPU frequency does not work right now, that
won't help you much right now.

Regards,

Stephan


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
