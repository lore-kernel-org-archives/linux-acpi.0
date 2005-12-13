From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI boot fix for 2.6.15
Date: Tue, 13 Dec 2005 00:43:00 -0500
Message-ID: <20051213054300.GA7401@redhat.com>
References: <20051213052834.GI23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051213052834.GI23384-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 13, 2005 at 06:28:34AM +0100, Andi Kleen wrote:
 > 
 > Hallo,
 > 
 > I have the following patch in my x86-64 tree because it was needed
 > to boot without acpi=off on several of the machines here. 
 > Without it the ACPI device setup code would always create a loop
 > in the ACPI device tree and eventually some other code walking
 > it would hang the machine.
 > 
 > The patch has been around for a long time - it was originally 
 > done by Thomas Renninger - and has even been shipped in SUSE 10.0
 > so it was well tested
 > (which was 2.6.13 based, there the problem only hit occasionally,
 > in 2.6.14+ it seems to happen more frequently for some reason)
 > 
 > I think it was queued in the ACPI trees too and acked by the
 > ACPI poeople.
 > 
 > I know Len skipped the ACPI update for .15 for some reason,
 > but could we perhaps merge this safe patch. It would help
 > my test machines at least :)

It got merged on Dec 1st.

		Dave



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
