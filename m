From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Wed, 16 Feb 2005 15:41:59 +0100
Message-ID: <20050216144156.GA4372@crusoe.alcove-fr>
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk> <20050214105837.GE3233@crusoe.alcove-fr> <20050214203211.GA8007@ucw.cz> <20050215161412.GC20951@pern.dea.icai.upco.es>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215161412.GC20951-NfIQswJzSEaq9fEpoSJUslHdEuJhDOxL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Romano Giannetti <romanol-qvIf60buks8@public.gmane.org>, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Matthew Garrett <mgarrett-QGMSyCZBOSwv4zxTlrOuLwNdhmdF6hFW@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 15, 2005 at 05:14:12PM +0100, Romano Giannetti wrote:

> On Mon, Feb 14, 2005 at 09:32:11PM +0100, Vojtech Pavlik wrote:
> >  
> > Yes, I'd like to see that. The other possible way is have the input
> > layer generate ACPI events for power-related keys.
> > 
> 
> I beg your pardon, but I have a very strange problem with ACPI event on a
> Sony laptop. Probably it's completely unraleted, but if you have time to
> have a look, it is on bugzilla too:
> 
> http://bugme.osdl.org/show_bug.cgi?id=4124

Strange indeed.

First thing to test is to disable sonypi (either rebuild a kernel
without it or rename the module so it will not get loaded again),
then reboot and see if you still have problems.

If you do, the problem is ACPI/input related.

If you don't, the strangeness comes from some interraction with
sonypi.

Stelian.
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
