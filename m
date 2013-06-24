From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] ACPI video driver document update
Date: Mon, 24 Jun 2013 14:01:49 +0200
Message-ID: <3098690.8XmNSpKuSe@vostro.rjw.lan>
References: <1371712137-4019-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48989 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab3FXLwW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jun 2013 07:52:22 -0400
In-Reply-To: <1371712137-4019-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Micael Dias <kam1kaz3@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thursday, June 20, 2013 03:08:54 PM Aaron Lu wrote:
> ACPI video driver's document is pretty outdated and needs updating.
> Patch 1 adds description for brightness_switch_enabled kernel command
> line option;
> Patch 2 moves the document for ACPI video driver from Documentation/power
> to Documentation/ACPI, since it is a document for the ACPI video driver;
> Patch 3 updates the video driver's document by focusing on how backlight
> is controlled by it.
> 
> Aaron Lu (3):
>   ACPI / video: add description for brightness_switch_enabled
>   ACPI / video: move video_extension.txt to Documentation/acpi
>   ACPI / video: update video_extension.txt for backlight control
> 
>  Documentation/acpi/video_extension.txt  | 106 ++++++++++++++++++++++++++++++++
>  Documentation/kernel-parameters.txt     |   9 +++
>  Documentation/power/video_extension.txt |  37 -----------
>  3 files changed, 115 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/acpi/video_extension.txt
>  delete mode 100644 Documentation/power/video_extension.txt

All queued up for 3.11.

Thanks,
Rafael


