From: Voluspa <voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: Re: RE: acpidump replaces acpidmp
Date: Wed, 17 Aug 2005 09:45:09 +0200
Message-ID: <20050817094509.201ff8cc.voluspa@telia.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300456A26A@hdsmsx401.amr.corp.intel.com>
	<200508161532.34578.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508161532.34578.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 16 Aug 2005 15:32:34 -0600 Bjorn Helgaas wrote:
> On Tuesday 16 August 2005 12:23 pm, Brown, Len wrote:
> > Mats,
> > Does the latest acpidump work for you now?
> > can we obsolete /proc/acpi/fadt,dsdt?
> 
> pmtools-20050804 doesn't work at all on ia64, because
> the RSDP doesn't live where you expect it.  We export
> /sys/firmware/efi/systab with the addresses you want.
> 
> The attached patch adds this, fixes a bunch of

./acpidump -t DSDT | ./acpixtract > DSDT
or
./acpidump -b -t DSDT > DSDT

show no difference to /proc/acpi/dsdt in
pmtools-20050804 both with and without Bjorns patch.

And I guess /proc/acpi/fadt shouldn't be exactly as
./acpidump -b -t FACP > FACP 'cos it's not.

So, it's working on my end.

Mvh
Mats Johannesson
--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
