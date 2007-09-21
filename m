From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH 6/7] ACPI: thinkpad-acpi: dequeue all
	pending hot key	events at once
Date: Fri, 21 Sep 2007 10:53:40 -0300
Message-ID: <20070921135340.GA11125@khazad-dum.debian.net>
References: <11902962603691-git-send-email-hmh@hmh.eng.br>
	<11902962613565-git-send-email-hmh@hmh.eng.br>
	<200709202042.22724.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200709202042.22724.lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 20 Sep 2007, Len Brown wrote:
> On Thursday 20 September 2007 09:50, Henrique de Moraes Holschuh wrote:
> > Receive all pending hot key events at once from a single notification, and
> > don't complain if the queue is empty.

Maybe I should have s/hot.?key/HKEY/ throughout this patch.

The HKEY handler is the thinkpad-specific handler to message-pass
interesting events to the O.S. This include hot key pressing, but also
inclures: LID open/close, radio switch toggling, what looks like thermal
alarms, reason for wakeup (bay eject, whatever), notification of impending
undock (to show a helper to the user explaining how to undock a x40/x60,
etc)... and only IBM and Lenovo knows what else.  Hot key presses are just
one of the many things reported through thinkpad HKEY events.

> If this is really an event due to an hotkey (emphasis on the word KEY:-),
> why is it being sent via netlink instead of via input?

Like I said, if it hit that branch, it is some other notification than a hot
key press :-)  Yeah, it is non-obvious.

I will rework the patch to use the word HKEY event instead of hotkey event
where applicable.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
