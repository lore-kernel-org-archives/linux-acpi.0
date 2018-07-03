From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Date: Tue, 3 Jul 2018 14:06:01 +0100
Message-ID: <20180703130601.GA1010@e107155-lin>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: rafael@kernel.org, lenb@kernel.org, andy.shevchenko@gmail.com, ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com, vikram.prakash@broadcom.com, scott.branden@broadcom.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 03, 2018 at 02:52:40PM +0530, Srinath Mannam wrote:
> This patch provides a function, to get of_device_id after
> matching with ACPI device _DSD object compatible property
> in the case driver does not contain acpi_device_id list
> and driver probe called for ACPI device ID PRP0001 with
> compatible property match with of_device_id compatible.
>

So, IIUC you are adding this to get of_device_id and then fetch data ptr
from it. Can we see the user in some driver ?

--
Regards,
Sudeep
