From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V6 0/7] dmaengine: qcom_hidma: add support for bugfixed HW
Date: Tue, 5 Dec 2017 23:05:52 +0100
Message-ID: <CAJZ5v0gq-Xv1V90GEcfxdnrADQn2Gern=LBnsbSzmrU9M0+FEQ@mail.gmail.com>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 5, 2017 at 6:04 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Introduce new ACPI and OF device ids for thw HW along with the helper
> functions.
>
> Changes from v5:
> * use struct device as a calling parameter to get_match_data() callback
> so that we can reuse the existing OF API.
> * revert the change on acpi_get_match_data() to V4.
>
> Sinan Kaya (7):
>   Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
>   ACPI / bus: Introduce acpi_get_match_data() function
>   device property: Introduce a common API to fetch device match data
>   OF: properties: Implement get_match_data() callback
>   ACPI: properties: Implement get_match_data() callback
>   dmaengine: qcom_hidma: Add support for the new revision
>   dmaengine: qcom_hidma: Add identity register support

Sakari, can you please have a look at this series?

I'm particularly interested in your opinion on patches [2-3/7] and [5/7].

Thanks,
Rafael
