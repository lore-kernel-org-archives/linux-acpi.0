From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Centrino speedstep
Date: Sun, 09 Jan 2005 23:04:09 +0100
Message-ID: <m21xcumf8m.fsf@phoenix.squirrel.nl>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl>
	<20041228212653.GA8436@dominikbrodowski.de>
	<m2vfalc53k.fsf@phoenix.squirrel.nl> <41D30842.4040204@paranoici.org>
	<20041229205905.GA12181@dominikbrodowski.de>
	<m2sm5o23ix.fsf@phoenix.squirrel.nl>
	<20041229214629.GA21054@dominikbrodowski.de>
	<m24qi48z4q.fsf@phoenix.squirrel.nl> <41D8366F.1040305@paranoici.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41D8366F.1040305-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org> (ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org's
 message of "Sun, 02 Jan 2005 18:59:11 +0100")
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

ultrakorne <ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org> writes:

> did those 2 changes fix your problems?
> i have this problem too, and i "fixed" with echo a new max ... but now
> as suggested i'll fix the dsdt

Using msr_is32_perf_status I found out that the actual frequencies are 
1500, 1200, 1000, 800, 600 (Mhz). The original DSDT reports 
1600, 1400, 1200, 800, 600. 

Another typical DSDT brokenness?

-- Johan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
