From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/6] ACPI: dock: convert sysfs attributes to an
	attribute_group
Date: Mon, 19 Oct 2009 18:38:44 -0700
Message-ID: <20091020013844.GB24370@core.coreip.homeip.net>
References: <20091019211132.5412.80438.stgit@bob.kio> <20091019211424.5412.15540.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:44655 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522AbZJTBny (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Oct 2009 21:43:54 -0400
Content-Disposition: inline
In-Reply-To: <20091019211424.5412.15540.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: =shaohua.li@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 19, 2009 at 03:14:24PM -0600, Alex Chiang wrote:
> As suggested by Dmitry Torokhov, convert the individual sysfs
> attributes into an attribute group.
> 
> This change eliminates quite a bit of copy/paste code in the
> error handling paths.
> 

Looks good to me, thank you for making the changes.

-- 
Dmitry
