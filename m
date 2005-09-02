From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: dsdt for Sony VGN-A190
Date: Fri, 2 Sep 2005 14:56:20 -0600
Message-ID: <200509021456.20267.bjorn.helgaas@hp.com>
References: <43188BB5.10808@gmail.com> <200509021217.40194.bjorn.helgaas@hp.com> <43189A10.4050304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43189A10.4050304-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 02 September 2005 12:29 pm, Jim Cromie wrote:
> Bjorn Helgaas wrote:
> >On Friday 02 September 2005 11:28 am, Jim Cromie wrote:
> >>attached is result of:
> >># |cat /proc/acpi/dsdt > dsdt.aml| and |iasl -d dsdt.aml > dsdt.asl|
> >>
> >>I would have uploaded it, but the register-user page didnt exist.
> >>
> >>back of laptop has this model number PCG-8Q5L
> >>top has this one VGN-A190.  go figure.
> >>
> >>I hope the file has what you need, otherwize let me know.
> >
> >Is this related to a problem report?  If so, you might
> >open a report at http://bugzilla.kernel.org and attach
> >the DSDT and other relevant information there.
> >
> Sorry,
> Basically, Im reporting cuz of this log entry:
> 
> Aug 23 07:10:46 harpo kernel:   SE model detected, unsupported, trying 
> default values, supply the developers with your DSDT
> Aug 23 07:10:46 harpo kernel: ACPI: Battery Slot [BAT1] (battery present)
> Aug 23 07:10:46 harpo kernel: ACPI: Power Button (CM) [PWRB]
> Aug 23 07:10:46 harpo kernel: ACPI: Lid Switch [LID]

I'm afraid you'll have to give a bit more context.  The
complete dmesg log would be a start, as well as the
specific kernel you're running.  I don't see the "SE model
detected" message you quote in the current upstream kernel.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
