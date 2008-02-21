From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI patches for Linux-2.6.25-rc2
Date: Thu, 21 Feb 2008 07:26:54 -0500
Message-ID: <200802210726.54416.lenb@kernel.org>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org> <20080221111812.GA5032@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39488 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbYBUM1N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 07:27:13 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m1LCQxnH013713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 21 Feb 2008 12:27:01 GMT
In-Reply-To: <20080221111812.GA5032@homac.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Thursday 21 February 2008 06:18, Holger Macht wrote:
> On Thu 21. Feb - 04:37:45, Len Brown wrote:
> > sorry if this is a repeat.
> > backing down to git 1.5.4 to see if it can send
> > messages that vger.kernel.org likes...
> 
> Any specific reason why the patch I sent one week ago should not not go
> into 2.6.25-rc2?
> 
>   ACPI: Do not pass NULL to acpi_get_handle() when looking for _EJD
> 

I didn't notice that one.

it is on the test branch now.

thanks,
-Len
