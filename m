From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Thu, 30 Dec 2004 12:07:23 +0100
Message-ID: <20041230110723.GD19199@poupinou.org>
References: <20041228212653.GA8436@dominikbrodowski.de> <m2vfalc53k.fsf@phoenix.squirrel.nl> <41D30842.4040204@paranoici.org> <20041229205905.GA12181@dominikbrodowski.de> <m2sm5o23ix.fsf@phoenix.squirrel.nl> <20041229214629.GA21054@dominikbrodowski.de> <m24qi48z4q.fsf@phoenix.squirrel.nl> <20041230074241.GB8464@dominikbrodowski.de> <m2is6kuo63.fsf@phoenix.squirrel.nl> <20041230103003.GA8206@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041230103003.GA8206-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 30, 2004 at 11:30:03AM +0100, Dominik Brodowski wrote:
> On Thu, Dec 30, 2004 at 10:32:20AM +0100, Johan Vromans wrote:
> > Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org> writes:
> > 
> > > Yes, indeed. These seem to be the right places for modification.
> > 
> > Okay, will do.
> > 
> > However, that brings up an interesting question: what guarantees that
> > the figures in the tables match the actual capabilities of the CPU?
> > Currently, it seems that my 1.5Ghz CPU is happily running at 1.6Ghz.
> 
> Run "x86info --mhz" and you'll most probably see the CPU runs at 1.5GHz 
> even though it is reported by ACPI as 1.6GHz. 
> 

Its maybe possible to get MSR MSR_IA32_PERF_STATUS and decode it in
userspace?

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
