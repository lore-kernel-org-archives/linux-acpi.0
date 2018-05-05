From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] clk: x86: Add ST oscout platform clock
Date: Fri, 04 May 2018 20:11:02 -0700
Message-ID: <152548986202.138124.14463361929719361009@swboyd.mtv.corp.google.com>
References: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
 <1525453639-30575-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525453639-30575-2-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com, mturquette@baylibre.com, christian.koenig@amd.com, airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Quoting Akshu Agrawal (2018-05-04 10:07:18)
> Stoney SoC provides oscout clock. This clock can support 25Mhz and
> 48Mhz of frequency.
> The clock is available for general system use.
> =

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
> v2: config change, added SPDX tag and used clk_hw_register_.
> v3: Fix kbuild warning for checking of NULL pointer

I replied on some older patch. Same comments apply still.
