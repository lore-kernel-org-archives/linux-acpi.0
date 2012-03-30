From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 57/76] ACPI / Video: blacklist some samsung laptops
Date: Fri, 30 Mar 2012 08:16:46 -0400
Message-ID: <4F75A42E.3030704@kernel.org>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>	<1333102459-23750-1-git-send-email-lenb@kernel.org>	<0e569b120d19c35dcc4f5549956cd884c3241270.1333101989.git.len.brown@intel.com> <CAHR064iEVsoMiP1PYzXeZeZzOFCPTk1YDBty6nHAfzej2qh_qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57797 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab2C3MQu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 08:16:50 -0400
In-Reply-To: <CAHR064iEVsoMiP1PYzXeZeZzOFCPTk1YDBty6nHAfzej2qh_qA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>


> Sorry for that but this patch was re-sent recently, and Matthew told
> me to do that this should be done in samsung-laptop.c instead.

Okay, I'll revert the (soon to be un-necessary) blacklist entries.

thanks,
-Len
