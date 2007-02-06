From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.20 poweroff regression on se7525gp2
Date: Mon, 5 Feb 2007 22:26:13 -0500
Message-ID: <200702052226.13737.lenb@kernel.org>
References: <200702050012.38485.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54052 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbXBFD1c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 22:27:32 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l163QJZ3015721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 6 Feb 2007 03:27:29 GMT
In-Reply-To: <200702050012.38485.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Monday 05 February 2007 00:12, Len Brown wrote:
> With 2.6.19.2, init 0 works
> with 2.6.20, it causes this box to reset when it should poweroff, and thus it reboots.

Turns out that USB broke poweroff:
http://bugzilla.kernel.org/show_bug.cgi?id=7945

-Len
