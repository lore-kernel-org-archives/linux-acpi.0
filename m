From: Norbert Preining <preining@logic.at>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Fri, 18 Feb 2005 14:38:16 +0100
Message-ID: <20050218133816.GA13745@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <200502152038.00401.stefandoesinger@gmx.at> <20050217190815.GC4925@gamma.logic.tuwien.ac.at> <200502172158.56721.stefandoesinger@gmx.at> <20050218104633.GA28246@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Disposition: inline
In-Reply-To: <20050218104633.GA28246@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan =?iso-8859-15?Q?D=F6singer?= <stefandoesinger@gmx.at>
Cc: acpi-devel@lists.sourceforge.net, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>, Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

On Fre, 18 Feb 2005, Norbert Preining wrote:
> I tried:
> 	2.6.11-rc3-mm2 + Xorg + DRI disabled
> and this works.
>=20
> I cannot enable dri/drm with the cvs version of the drm modules, beca=
use
> the drm modules do not compile for -mm kernels, since there is the pa=
tch
> for multiple agp bridges included (that's the reason why I tried -rc4

=46inal observation: After patching in the changes from mm kernels for
multiple agp bridges to the drm-source code (the patch
drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch from the
broken out archive) I could compile the drm-trunk-src modules.

So now I am running with 2.6.11-rc3-mm2 + Xorg + DRI enabled (and
working) with the drm modules from drm-trunk-module-src.

Outcome: freeze when switching to X. As with the other modules (in fact
I think that most of the changes to the drm stuff are included in the m=
m
kernel, so this should not change anything, as mm pulls from bk-agpgart=
,
bk-drm-via) a funny screen, and the CapsLock light is blinking.

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Norbert Preining <preining AT logic DOT at>                 Universit=E0=
 di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 5996=
6-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
`That young girl is one of the least benightedly
unintelligent organic life forms it has been my profound
lack of pleasure not to be able to avoid meeting.'
                 --- Marvin's first ever compliment about anybody.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
