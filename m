From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [patch 4/7] asus-laptop: add backlight support
Date: Fri, 26 Jan 2007 10:49:23 +0100
Message-ID: <200701261049.23781.corentincj@iksaif.net>
References: <200701251254.50198.corentincj@iksaif.net> <200701260246.21515.lenb@kernel.org>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:57469 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161014AbXAZJtZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Jan 2007 04:49:25 -0500
In-Reply-To: <200701260246.21515.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

> wups, my message about LED  CLASS was garbled.
> What I should have written is:
>
> Both of these select's should be "depends on"
> select is generally considered evil and should be avoided if at all
> possible.
>
Yep, but : asus_acpi and ibm-acpi use select.  But if select is considered 
evil, I think I will use "depends on".

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
