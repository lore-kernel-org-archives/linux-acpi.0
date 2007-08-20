From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] [-mm] FS: file name must be unique in the same dir in procfs
Date: Mon, 20 Aug 2007 12:45:17 +0200
Message-ID: <200708201245.17780.oliver@neukum.org>
References: <1187605699.2920.147.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:47479 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751303AbXHTKpW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Aug 2007 06:45:22 -0400
In-Reply-To: <1187605699.2920.147.camel@acpi-hp.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Am Montag 20 August 2007 schrieb Zhang Rui:
> Files name must be unique in the same directory.
> 
> Bug is reported here: 
> http://bugzilla.kernel.org/show_bug.cgi?id=8798

Then I'd say fix the callers. This will paper over bugs.

	Regards
		Oliver

