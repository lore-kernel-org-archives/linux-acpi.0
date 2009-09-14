From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/3] dell-laptop: fix rfkill memory leak on unload
Date: Mon, 14 Sep 2009 11:46:16 +0100
Message-ID: <20090914104616.GA6170@srcf.ucam.org>
References: <1252925033-29696-1-git-send-email-corentincj@iksaif.net> <1252925033-29696-2-git-send-email-corentincj@iksaif.net> <1252925033-29696-3-git-send-email-corentincj@iksaif.net> <1252925033-29696-4-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48257 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbZINKqV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 06:46:21 -0400
Content-Disposition: inline
In-Reply-To: <1252925033-29696-4-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Johannes Berg <johannes@sipsolutions.net>

On Mon, Sep 14, 2009 at 12:43:53PM +0200, Corentin Chary wrote:
> rfkill_unregister() should always be followed by rfkill_destroy()
> 
> Cc: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
