From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Fri, 18 Feb 2005 19:04:16 +0100
Message-ID: <200502181904.17517.stefandoesinger@gmx.at>
References: <20050214211105.GA12808@elf.ucw.cz> <20050218104633.GA28246@gamma.logic.tuwien.ac.at> <20050218133816.GA13745@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050218133816.GA13745-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Freitag, 18. Februar 2005 14:38 schrieb Norbert Preining:
> On Fre, 18 Feb 2005, Norbert Preining wrote:
> > I tried:
> >  2.6.11-rc3-mm2 + Xorg + DRI disabled
> > and this works.
> >
> > I cannot enable dri/drm with the cvs version of the drm modules, because
> > the drm modules do not compile for -mm kernels, since there is the patch
> > for multiple agp bridges included (that's the reason why I tried -rc4
>
> Final observation: After patching in the changes from mm kernels for
> multiple agp bridges to the drm-source code (the patch
> drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch from the
> broken out archive) I could compile the drm-trunk-src modules.
>
> So now I am running with 2.6.11-rc3-mm2 + Xorg + DRI enabled (and
> working) with the drm modules from drm-trunk-module-src.
>
> Outcome: freeze when switching to X. As with the other modules (in fact
> I think that most of the changes to the drm stuff are included in the mm
> kernel, so this should not change anything, as mm pulls from bk-agpgart,
> bk-drm-via) a funny screen, and the CapsLock light is blinking.
Kernel panik. Can you ssh into your maschine and get a dmesg? I recommend you 
to write to the dri devs.

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
