From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Sun, 9 Jan 2005 23:52:54 +0100
Message-ID: <20050109225254.GA27866@dominikbrodowski.de>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl> <20041228212653.GA8436@dominikbrodowski.de> <m2vfalc53k.fsf@phoenix.squirrel.nl> <41D30842.4040204@paranoici.org> <20041229205905.GA12181@dominikbrodowski.de> <m2sm5o23ix.fsf@phoenix.squirrel.nl> <20041229214629.GA21054@dominikbrodowski.de> <m24qi48z4q.fsf@phoenix.squirrel.nl> <41D8366F.1040305@paranoici.org> <m21xcumf8m.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m21xcumf8m.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 09, 2005 at 11:04:09PM +0100, Johan Vromans wrote:
> ultrakorne <ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org> writes:
> 
> > did those 2 changes fix your problems?
> > i have this problem too, and i "fixed" with echo a new max ... but now
> > as suggested i'll fix the dsdt
> 
> Using msr_is32_perf_status I found out that the actual frequencies are 
> 1500, 1200, 1000, 800, 600 (Mhz). The original DSDT reports 
> 1600, 1400, 1200, 800, 600. 
> 
> Another typical DSDT brokenness?

It definitely seems so.

Thanks,
	Dominik


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
