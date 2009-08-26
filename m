From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 6/6] thermal: disable polling if passive_delay and
	polling_delay are both unset
Date: Wed, 26 Aug 2009 17:25:04 +0100
Message-ID: <20090826162504.GB15868@srcf.ucam.org>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl> <1251303445-25317-7-git-send-email-elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751999AbZHZQZL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1251303445-25317-7-git-send-email-elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 26, 2009 at 06:17:25PM +0200, Frans Pop wrote:
> Otherwise polling will continue for the thermal zone even when
> it is no longer needed, for example because forced passive cooling
> was disabled.
> 
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Matthew Garrett <mjg@redhat.com>
> Cc: Zhang Rui <rui.zhang@intel.com>

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
