From: Jim Summers <jsummers-5f/76mLIbwCHXe+LvDLADg@public.gmane.org>
Subject: Re: Learning ACPI
Date: Mon, 31 Jan 2005 08:17:57 -0600
Message-ID: <41FE3E15.5060705@cs.ou.edu>
References: <41FA9F93.4090105@cs.ou.edu> <20050129161334.GA28055@hell.org.pl>
Reply-To: jsummers-5f/76mLIbwCHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20050129161334.GA28055-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Listacpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor wrote:
> Thus wrote Jim Summers:
> 
>>I guess I am not understanding how, if the acpid is correctly monitoring 
>>the lid state then why would it not fire the events/actions?  I can 
>>porvide more info, dmesg output etc...
> 
> 
> Basically, the lid stat is polled, while the events are interrupt driven.
> For the record, could you try with an older ( <= 2.6.7) kernel?

I will give it a go.  If it works in 2.6.7 what would have gotten lost 
in 2.6.10?

I have not applied the 2005-01-26 patch for 2.6.10.  Could that fix the 
lost interrupt issue?

TIA

  There seems
> to be an issue in handling EC interrupts in recent kernels, it might be
> that.
> Best regards,
> 

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
