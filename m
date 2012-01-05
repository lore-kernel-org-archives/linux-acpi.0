From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 1/4] ACPI: EC: Add ec_get_handle()
Date: Thu, 5 Jan 2012 18:22:45 +0000
Message-ID: <20120105182245.GC24242@srcf.ucam.org>
References: <1325617358-8286-1-git-send-email-seth.forshee@canonical.com>
 <1325617358-8286-2-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1325617358-8286-2-git-send-email-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Len Brown <lenb@kernel.org>, Azael Avalos <coproscefalo@gmail.com>, Thomas Renninger <trenn@suse.de>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 03, 2012 at 01:02:35PM -0600, Seth Forshee wrote:
> toshiba_acpi needs to execute an AML method within the EC namespace
> to make hotkeys work on some platforms. Provide an interface to
> allow it to easily get a handle to the EC namespace for this purpose.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Looks good to me - Len, do you want to take this through your tree or 
should I?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
