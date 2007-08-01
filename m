From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: 2.6.21-rc1: T60 ACPI issues
Date: Wed, 1 Aug 2007 12:47:49 -0300
Message-ID: <20070801154749.GK23111@khazad-dum.debian.net>
References: <20070801135820.GA8266@mellanox.co.il>
	<Pine.LNX.4.64.0708011516540.15447@blonde.wat.veritas.com>
	<20070801145607.GB8480@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070801145607.GB8480-VPRAkNaXOzVS1MOuV/RT9w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Michael S. Tsirkin" <mst-LDSdmyG8hGV8YrgS2mwiifqBs+8SCbDb@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

(CC changed from Borislav to ibm-acpi-devel).

On Wed, 01 Aug 2007, Michael S. Tsirkin wrote:
> > > 2. Pressing Fn/F4 does not trigger suspend to ram
> > >    This normally triigers ACPI event which triggers suspend to RAM on Ubuntu
> > >    (echo mem > /sys/power/state works)
> > 
> > I'll bet this is your CONFIG_THINKPAD_ACPI_INPUT_ENABLED=y.
> > I got the same, see my "THINKPAD_ACPI_INPUT_ENABLED seems regressive"
> > mail to Henrique and lkml an hour ago.

[...]

> > > 3. After suspend to RAM, system wakes up but laptop's screen is blank,
> > >    switching VTs etc does not help.
> > >    External screen wakes up OK though.
> > >    dmesg output from boot attached.
> > 
> > (I've not had that.)
> 
> Bingo.
> sudo rmmod thinkpad_acpi cures both 2 and 3.
> Thanks for pointing this out.

I can see how it would help with (2), as that prompty tells the firmware to
issue its default ACPI events for Fn+F4 upon removal.  But I have *NO* idea
what thinkpad_acpi might be doing that is causing issues with the wake up
after a resume.

Please open a bug in bugzilla.kernel.org about it, and attach the full debug
output of a suspend+resume cycle with and without thinkpad-acpi loaded.

Also, please try the same with thinkpad-acpi loaded, but
CONFIG_THINKPAD_ACPI_INPUT_ENABLED set to N.  If the problem goes away,
please retest, but set hotkey_enable to 1 and do an "cat
/sys/bus/platform/devices/thinkpad_acpi/hotkey_recommended_mask >
/sys/bus/platform/devices/thinkpad_acpi/hotkey_mask" before the sleep.

You will probably need to enable a bunch of debug options in ACPI and
thinkpad-acpi to get good enough logs.  It is probably worth posting the
acpid logs too: the real difference might be there.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
