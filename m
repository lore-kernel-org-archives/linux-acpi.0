From: Norbert Preining <preining@logic.at>
Subject: Re: suspend to ram regression from 2.6.28 to 2.6.29-rc2
Date: Tue, 27 Jan 2009 01:02:38 +0100
Message-ID: <20090127000238.GA2138@gamma.logic.tuwien.ac.at>
References: <20090126221554.GA15492@gamma.logic.tuwien.ac.at> <497E3750.8030501@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:42859 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbZA0ACw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jan 2009 19:02:52 -0500
Content-Disposition: inline
In-Reply-To: <497E3750.8030501@dbservice.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mo, 26 Jan 2009, Tomas Carnecky wrote:
> Try this: http://bugzilla.kernel.org/show_bug.cgi?id=12495#c2
> With the four patches (three linked to directly and the one from bug 
> 12422) I can suspend and resume fine.

Confirmed. Adding these four patches make S2R work again.

Thanks a lot.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CLUN (n.)
A leg which has gone to sleep and has to be hauled around after you.
			--- Douglas Adams, The Meaning of Liff
