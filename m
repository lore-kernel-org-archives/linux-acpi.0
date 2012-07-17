From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/5] acpi : remove index from acpi_processor_cx structure
Date: Tue, 17 Jul 2012 22:34:19 +0200
Message-ID: <201207172234.19751.rjw@sisk.pl>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org> <1342127026-1526-2-git-send-email-daniel.lezcano@linaro.org> <201207172232.41412.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:44979 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756628Ab2GQU2l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jul 2012 16:28:41 -0400
In-Reply-To: <201207172232.41412.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, July 17, 2012, Rafael J. Wysocki wrote:
> On Thursday, July 12, 2012, Daniel Lezcano wrote:
> > Remove the index field. It could be given without adding extra
> > information in the cx structure.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Applied to the 'pm-cpuidle' branch of the linux-pm.git tree.

This patch wasn't applied in fact, for reasons given elsewhere.

Sorry for sending a misleading message.

Rafael
