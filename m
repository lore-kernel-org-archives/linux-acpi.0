From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sat, 19 Jan 2008 15:43:28 +0000
Message-ID: <20080119154328.GA11024@srcf.ucam.org>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801171504.26361.lenb@kernel.org> <20080117213135.GF5547@mit.edu> <200801190240.45718.lenb@kernel.org> <20080119120830.GA16308@khazad-dum.debian.net> <20080119141727.GJ28387@mit.edu> <20080119153304.GA27060@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:47705 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762017AbYASPno (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jan 2008 10:43:44 -0500
Content-Disposition: inline
In-Reply-To: <20080119153304.GA27060@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Theodore Tso <tytso@MIT.EDU>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, Jan 19, 2008 at 01:33:04PM -0200, Henrique de Moraes Holschuh wrote:

> Yes.  This is no easy problem asking for a quick hack as a solution.  It is
> not impossible to solve, but it will definately require more than hacks on
> our side to get it done properly.

The only way to get it done properly is to ensure that we're compatible 
with Windows, and to get vendors to tell us when we're not. Offering 
them any mechanism that allows them to special-case Linux will just lead 
to them doing so and ignoring the problem, which will probably then trip 
up other systems that don't special-case Linux. Let's not go down this 
path. The fact that we're even having to have this conversation should 
indicate that it's not a good idea.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
