From: Romano Giannetti <romanol-qvIf60buks8@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 17:10:00 +0100
Message-ID: <20050216161000.GA3381@pern.dea.icai.upco.es>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050216093454.GC22816@pern.dea.icai.upco.es> <42135EAE.8030407@gmx.net>
Reply-To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <42135EAE.8030407-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 16, 2005 at 03:54:38PM +0100, Carl-Daniel Hailfinger wrote:
> Romano Giannetti schrieb:
> > 
> > I tried with my Sony Vaio FX701. No luck. It goes S3 ok, but it will never
> > come back (blank screen, HDD led fixed on). 
> > 
> > I am wishing to help, imply tell me what I have to do.
> 
> Please tell us about your graphics chipset, your .config, your
> dmesg and the modules loaded. Then we my be able to help.

Oops, sorry, I should have added the info before. My apologies. 

Here will find all the info (if you need more, tell me). Note that I tried
with and without ndiswrapper driver loaded, and I have the same hang on
resume (blank screen, HDD light fixed on, and no answer to wireless pings). 

One more note: the ndiswrapper *did* survive OK to a disk suspend cycle. 

I am running an up-to-date Mandrake 10.0 distribution, with 
a kernel 2.6.11-rc1 (Linus tree), on a Sony Vaio PGC-FX701 which is almost
working perfectly. 

* Patch applied: 
  - a little patch for ALPS pad detection.
  http://www.dea.icai.upco.es/romano/linux/alps-detection-2611rc1.txt

* .config:
  http://www.dea.icai.upco.es/romano/linux/config-2.6.11rc1.txt

* lsmod after boot: 
  http://www.dea.icai.upco.es/romano/linux/lsmod.txt

* lspci -vv
  http://www.dea.icai.upco.es/romano/linux/lspci.txt

* dmesg
  http://www.dea.icai.upco.es/romano/linux/dmesg.txt

* /proc/acpi/dsdt
  http://www.dea.icai.upco.es/romano/linux/mydsdt.bin

More data on http://perso.wanadoo.es/r_mano/vaio/vaio.html

Thanks again,
             Romano


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
