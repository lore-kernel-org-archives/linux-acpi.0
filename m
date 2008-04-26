From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch 00/54] PNP cleanup, v4
Date: Sun, 27 Apr 2008 01:47:32 +0200
Message-ID: <4813BF14.8090109@keyaccess.nl>
References: <20080425183807.366134771@ldl.fc.hp.com> <4813BBE9.2010803@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020901080502050401040701"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:35169 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbYDZXrZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Apr 2008 19:47:25 -0400
In-Reply-To: <4813BBE9.2010803@keyaccess.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

This is a multi-part message in MIME format.
--------------020901080502050401040701
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 27-04-08 01:34, Rene Herman wrote:

> Good idea...

By the way, would you terribly mind submitting this alongside? It's been 
ages since we heard from Adam.

Rene

--------------020901080502050401040701
Content-Type: text/plain;
 name="pnp-maintainer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp-maintainer.diff"

diff --git a/MAINTAINERS b/MAINTAINERS
index a942f38..7b10551 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3171,8 +3171,8 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 
 PNP SUPPORT
-P:	Adam Belay
-M:	ambx1@neo.rr.com
+P:	Bjorn Helgaas
+M:	bjorn.helgaas@hp.com
 S:	Maintained
 
 PNXxxxx I2C DRIVER

--------------020901080502050401040701--
