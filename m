From: Jim Summers <jsummers-5f/76mLIbwCHXe+LvDLADg@public.gmane.org>
Subject: Re: Nothing in /proc/acpi/events
Date: Thu, 03 Feb 2005 10:10:23 -0600
Message-ID: <42024CEF.9020308@cs.ou.edu>
References: <4202321C.3060103@gmail.com>
Reply-To: jsummers-5f/76mLIbwCHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
In-reply-to: <4202321C.3060103-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Simon Walters wrote:
> Hi, I'm running Slackware 10.0 (and have tried others) on a Dell 
> Inspiron 1150. I have got acpi support in my kernel, but when I press 
> the power button or close the lid, nothing shows up in the 
> /proc/acpi/events file. I close acpid and cat the file, then press the 
> button or close the lid, and nothing comes up.

Does the state file get updated?

  What's wrong? I have
> tried it on the 2.4 and 2.6 kernels and neither work.

I am experiencing the same problem with a Dell 5100.

The list mentioned that the state files are polled and the events are 
int driven.  A question I have is why can events not be polled?  If it 
is an int problem, is that fixable with a modded dsdt?

I think Dell was putting out non-complying acpi stuff in their bios. 
One of the faculty in my department has a new Dell M60 and it seems to 
recognoze the PWRBTN event.  I haven't had time to mess with the lid on 
it.  But my bios is at the latest available and still nada.




> 
> Thanks in advance,
> Simon
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
