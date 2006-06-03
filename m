From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [patch 09/13] ACPI: Atlas ACPI driver
Date: Sat, 3 Jun 2006 19:48:12 +0800
Message-ID: <756b48450606030448n2ae50dddv90befbf4a637a354@mail.gmail.com>
References: <200606020314.k523EVi4028331@shell0.pdx.osdl.net>
	 <d120d5000606020533g431043a5r94e0ca7cce1799cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:17275 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932615AbWFCLsM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Jun 2006 07:48:12 -0400
Received: by wr-out-0506.google.com with SMTP id 69so914745wri
        for <linux-acpi@vger.kernel.org>; Sat, 03 Jun 2006 04:48:12 -0700 (PDT)
In-Reply-To: <d120d5000606020533g431043a5r94e0ca7cce1799cc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dtor_core@ameritech.net
Cc: "akpm@osdl.org" <akpm@osdl.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, luming.yu@intel.com

On 6/2/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> I think that you should free (unregister) input device only after
> button handler was unregistered, otherwise there is a risk that it
> will try to access already freed device. Other than that input part
> looks good.
>

Oops. Sorry about that. Thanks for the fix akpm.

jaya
