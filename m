From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: 2.6.20-rc4: known regressions with patches (v3)
Date: Thu, 11 Jan 2007 06:13:29 +0100
Message-ID: <20070111051329.GB21724@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701062216210.3661-AgDkxUvNf0y7TbgM5vRIOg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Robert Hancock <hancockr-fVOoFLC7IWo@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Sami Farin <7atbggg02-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>, gregkh-l3A5Bk7waGM@public.gmane.org, "Vladimir V. Saveliev" <vs-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>, xfs-masters-VZNHf3L845pBDgjK7y7TUQ@public.gmane.org, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch-Mmb7MZpHnFY@public.gmane.org>, Roland Dreier <rdreier-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, David Chinner <dgc-sJ/iWh9BUns@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brice Goglin <brice-vV262kQ/Wyo@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This email lists some known regressions in 2.6.20-rc4 compared to 2.6.19
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ibm-acpi: bay support disabled
References : http://lkml.org/lkml/2007/1/9/242
Submitter  : Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Caused-By  : Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
             commit 2df910b4c3edcce9a0c12394db6f5f4a6e69c712
Handled-By : Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Patch      : http://lkml.org/lkml/2007/1/9/242
Status     : patch to revert the commit available


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs)
References : http://lkml.org/lkml/2007/1/7/117
Submitter  : Malte Schr=F6der <MalteSch-Mmb7MZpHnFY@public.gmane.org>
Handled-By : Vladimir V. Saveliev <vs-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Patch      : http://lkml.org/lkml/2007/1/10/202
Status     : patch available


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
References : http://lkml.org/lkml/2007/1/5/308
Submitter  : Sami Farin <7atbggg02-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>
Handled-By : David Chinner <dgc-sJ/iWh9BUns@public.gmane.org>
Patch      : http://lkml.org/lkml/2007/1/7/201
Status     : patch available


Subject    : nVidia CK804 chipset: not detecting HT MSI capabilities
References : http://lkml.org/lkml/2007/1/5/215
Submitter  : Brice Goglin <brice-vV262kQ/Wyo@public.gmane.org>
             Robert Hancock <hancockr-fVOoFLC7IWo@public.gmane.org>
Handled-By : Brice Goglin <brice-vV262kQ/Wyo@public.gmane.org>
Patch      : http://lkml.org/lkml/2007/1/5/215
Status     : patch available


Subject    : KVM: guest crash
References : http://lkml.org/lkml/2007/1/8/163
Submitter  : Roland Dreier <rdreier-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Handled-By : Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Patch      : http://lkml.org/lkml/2007/1/9/280
Status     : patch available



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
