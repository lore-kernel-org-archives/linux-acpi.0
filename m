From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 32/70] ACPI: fix checkpatch.pl complaints in scan.c
Date: Sat, 21 Jun 2008 16:50:39 +0200
Message-ID: <87y74yx2o0.fsf@basil.nowhere.org>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
	<ad7f0d9feee6980a3ab3ea806854f56817d1da8e.1213947350.git.len.brown@intel.com>
	<87lk0zanvo.fsf@basil.nowhere.org>
	<1213993974.31598.31.camel@promb-2n-dhcp368.eng.vmware.com>
	<485C157A.5080803@firstfloor.org>
	<1213995600.31598.40.camel@promb-2n-dhcp368.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out03.alice-dsl.net ([88.44.63.5]:40788 "EHLO
	smtp-out03.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbYFUOuo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jun 2008 10:50:44 -0400
In-Reply-To: <1213995600.31598.40.camel@promb-2n-dhcp368.eng.vmware.com> (Alok Kataria's message of "Fri, 20 Jun 2008 13:59:59 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akataria@vmware.com
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>

Alok Kataria <akataria@vmware.com> writes:

I misread the patch sorry. It looked like you added error checking,
but I didn't notice that the function call had changed too.

Len was right of course.

-Andi
