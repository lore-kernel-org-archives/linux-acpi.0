From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 13:28:13 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005EFF0A4@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:12958 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751350AbWBCS2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 13:28:35 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juhani Rautiainen <juhani.rautiainen@gmail.com>
Cc: Joerg Sommrey <jo@sommrey.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tony@atomide.com, erik@slagter.name, alan@lxorguk.ukuu.org.uk

>If I understand errata correctly then enabling C2/C3 should be safe in
>SMP environment put not in single processor enviroment.

No, I would not assume SMP works when UP does not just because
SMP was not mentioned.  Things are generally easier to get right
in UP and harder to get right in SMP.

-Len
 

>
>Link:
>http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24472.pdf
>
