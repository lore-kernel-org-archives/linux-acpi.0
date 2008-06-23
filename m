From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: LMSENSORS: 2.6.26-rc,  enabling ACPI Termal Zone support costs
 sensors
Date: Mon, 23 Jun 2008 12:24:06 +0200
Message-ID: <485F79C6.20507@keyaccess.nl>
References: <485DA11C.7050906@keyaccess.nl>	<485DFF35.6080008@hhs.nl>	<485E505F.8010306@keyaccess.nl>	<485E61DE.6020202@hhs.nl> <20080623120844.5f722aa6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:47614 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYFWKX1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2008 06:23:27 -0400
In-Reply-To: <20080623120844.5f722aa6@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On 23-06-08 12:08, Jean Delvare wrote:

> No, the kernel does the right thing and does not need to be modified
> at all.

No Jean, this is totally unacceptable. No matter how you want to call 
things, 2.6.26 is going to break important functionality on millions of 
systems and you simply do not get to do that. Can you comment on the 
last patch posted? It's trivial:

http://lkml.org/lkml/2008/6/22/243

Rene.

