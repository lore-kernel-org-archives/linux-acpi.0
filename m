From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 15:54:38 +0100
Message-ID: <42135EAE.8030407@gmx.net>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050216093454.GC22816@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050216093454.GC22816-NfIQswJzSEaq9fEpoSJUslHdEuJhDOxL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Cc: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Romano Giannetti schrieb:
> On Tue, Feb 15, 2005 at 06:08:37PM +0100, Norbert Preining wrote:
> 
>>On Die, 15 Feb 2005, Carl-Daniel Hailfinger wrote:
>>
>>>To suspend and resume properly, call the following script as root:
>>
>>Success. 
> 
> I tried with my Sony Vaio FX701. No luck. It goes S3 ok, but it will never
> come back (blank screen, HDD led fixed on). 
> 
> I am wishing to help, imply tell me what I have to do.

Please tell us about your graphics chipset, your .config, your
dmesg and the modules loaded. Then we my be able to help.


Regards,
Carl-Daniel

P.S. If anyone of you is running SUSE 9.2, try their latest
kernels from ftp.suse.com/pub/projects/kernel/kotd/i386/HEAD/
Additionally, you may have to upgrade mkinitrd and udev with
packages from ftp.suse.com/pub/projects and
ftp.suse.com/pub/people (try searching around a bit and you'll
surely find them).
I'm running a kernel from there right now and can still use
S3 without problems on my Samsung P35.
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
