From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.6.12-rc1
Date: 18 Mar 2005 21:47:10 -0500
Message-ID: <1111200429.5935.13.camel@d845pe>
References: <1111127024.9332.157.camel@d845pe>
	 <20050318150129.GB22887@pern.dea.icai.upco.es>
	 <20050318152122.7994965b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050318152122.7994965b.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org, romanol-qvIf60buks8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-03-18 at 18:21, Andrew Morton wrote:
> Romano Giannetti <romanol-qvIf60buks8@public.gmane.org> wrote:
> >
> > Could I humble advocating pushing the patch
> >  http://bugme.osdl.org/attachment.cgi?id=4516&action=view ,please?
> It fixed a
> >  very bad regression in hotkey event from 2.6.9...
> 
> It seems to not be in ACPI bk yet.  What bug number is that actually
> attached to?  There seems to be no way to go backwards from the URL.


Yes, this is an important fix, and I'll be pushing
it up to-akpm tonight along with a bucket-full of
other important fixes.  The push to Linus yesterday
was to clear the pipeline for this next batch, which
should hopefully also make 2.6.12.

cheers,
-Len

ps. You can query bugzilla for comments containing string "id=4516"
and you find this is Luming's burst-mode EC patch:
http://bugzilla.kernel.org/show_bug.cgi?id=3851




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
