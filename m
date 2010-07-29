From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] acpi ec_sys: Be more cautious about ec write access
Date: Thu, 29 Jul 2010 22:16:12 +0200
Message-ID: <201007292216.13568.trenn@suse.de>
References: <1280434125-11943-1-git-send-email-trenn@suse.de> <1280434125-11943-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1280434125-11943-3-git-send-email-trenn@suse.de>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de, akpm@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 29 July 2010 10:08:45 pm Thomas Renninger wrote:
> +
> +	if (!write_support)
> +		acpi_ec_io_ops.write = NULL;
> +	if (!debugfs_create_file("io", 0600, dev_dir, ec, &acpi_ec_io_ops))
Wait, this is wrong. I send an updated patch in a second...

       Thomas
