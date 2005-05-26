From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem
 depends on sound-playing: irq 10: nobody cared!
Date: Thu, 26 May 2005 14:10:21 -0700
Message-ID: <20050526141021.61e3ca19.akpm@osdl.org>
References: <20050525224328.734adc03.akpm@osdl.org>
	<200505261007.40992.bjorn.helgaas@hp.com>
	<20050526102936.0c7016bd.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050526102936.0c7016bd.rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Cc: bjorn.helgaas-VXdhtT5mjnY@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hannes-diethelm-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org> wrote:
>
>  On Thu, 26 May 2005 10:07:40 -0600 Bjorn Helgaas wrote:
> 
>  | On Wednesday 25 May 2005 11:43 pm, Andrew Morton wrote:
>  | > This IRQ routing bug appears to be an ACPI thing.  Could someone
>  | > please reassign it?
> 
>  I can do that, but Bjorn's patch makes it appear to be a PCI bug
>  rather than an ACPI bug.  Any clarification on that?

OK, let's leave it as-is.  Hopefulls Hannes can test that patch soon.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
