From: "Leo \"costela\" Antunes" <costela@debian.org>
Subject: Re: [patch 2/2] [PATCH 2/2] ACPI: generic initramfs table override
   support #3
Date: Sat, 10 Oct 2009 16:08:03 +0200
Message-ID: <haq4g3$ncb$1@ger.gmane.org>
References: <20091009195508.694274257@suse.com> <20091009195907.635574715@suse.com> <20091009201908.GA1139@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58626 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbZJJOKl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Oct 2009 10:10:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mwce4-0007QF-C0
	for linux-acpi@vger.kernel.org; Sat, 10 Oct 2009 16:10:04 +0200
Received: from p54bae2cf.dip.t-dialin.net ([84.186.226.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 10 Oct 2009 16:10:04 +0200
Received: from costela by p54bae2cf.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 10 Oct 2009 16:10:04 +0200
In-Reply-To: <20091009201908.GA1139@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> I'm really unenthusiastic about this. The majority of use cases appea=
r=20
> to be people working around Linux bugs and never reporting the bugs t=
o=20
> us, leaving everybody worse off.

I can't judge the technical quality of the patch, but I don't think the
social side of it is a problem (assuming I correctly understood the
change in question).

Case in point: I reported a problem[0] with the thermal/fan subsystems
which was left unanswered and forced me to recompile kernels with
overridden DSDTs for every new release expecting a fix and eventually
replace the laptop in question. I'm obviously not demanding that my
problem be solved, but the point is that not all problems can be solved
in a timely fashion even when they are reported (for whatever reason:
lack of manpower, lack of test machines, etc), so avoiding this change
which could ease the testing of new DSDTs seems a bit sadistic. :)

Another point of view to the same argument is that the current situatio=
n
doesn't guarantee feedback either. The added hassle of needing a
recompile doesn't IMHO necessarily mean users report these sort of prob=
lems.

Just my technically inapt 0,2 =E2=82=AC. :)

Cheers

[0] http://thread.gmane.org/gmane.linux.acpi.devel/37612

--=20
Leo "costela" Antunes
[insert a witty retort here]

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
