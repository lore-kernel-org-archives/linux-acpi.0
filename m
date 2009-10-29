From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: remove HKEY disable functionality (triggers
 Ubuntu Karmic regression)
Date: Thu, 29 Oct 2009 20:46:34 -0200
Message-ID: <20091029224634.GA15435@khazad-dum.debian.net>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
	<1238819153-16004-8-git-send-email-hmh@hmh.eng.br>
	<20091028215838.38b362ad@mark-x41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091028215838.38b362ad@mark-x41>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Stosberg <mark-WmyhgDpj2fCHT8/ATrE1yw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 28 Oct 2009, Mark Stosberg wrote:
> With the release of Karmic upon us, perhaps there a short term fix that 
> can be made, like making the warning level less severe.

If the userspace in Ubuntu is triggering the warning, and you don't have
enough time to fix the issue properly (i.e. remove any code that
attempts to mess with hotkey_enable), the Ubuntu kernel team will have
to remove the WARN from the driver code, yes.

However, I recommend trying to fix the real bug, first.  There are
absolutely no known-valid reasons for any program to access the
hotkey_enable attribute.


Please ask someone who can reproduce the warning to check for debug output
from thinkpad-acpi, it will log to the kernel log the PID of the process
trying to access the deprecated attributes.  The user should check the PID
and use the ps command to find out what process corresponts to that PID:

Run this in a shell window:

tail -f /var/log/kern.log | grep "thinkpad_acpi"

then run whatever application causes the warnings to happen, or if they
are common, just wait for one to happen.  Thinkpad-acpi will log the PID
of the offending processes using a phrase like "access by process with
PID...".

I would be interested in the full log output by thinkpad-acpi showing the
problem.  In fact, I find it surprising that your automated bug report tool
doesn't attach to the bug report the last 100 lines of the kernel log or
somesuch...

Anyway, now that the user knows the PID of the process attempting to access
the deprecated attributes, he should immediately use the "ps PID", where PID
is the numerical value of the PID logged by thinkpad-acpi, to find out the
name and parameters of the process who accessed the deprecated attribute.

Maybe the user should also use "pstree -p" to help locate the parent of the
process if the PID resultued in something unhelpful (e.g. bash).

That could give us a clue about exactly why that attribute is being
accessed, especially if it is happening when someone is trying to test their
ALSA setup...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
