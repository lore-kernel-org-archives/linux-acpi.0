From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
Date: Wed, 25 Apr 2018 19:39:31 +0200
Message-ID: <20180425173931.GD2597@pd.tnic>
References: <20180419164528.GD5635@pd.tnic>
 <ffe6b459-c80a-d3c0-451d-0d21ae63da54@gmail.com>
 <20180419190323.GF5635@pd.tnic>
 <dba07329-2f85-2bde-85ea-5bdf26fb8df2@gmail.com>
 <20180422104849.GA32754@pd.tnic>
 <70c43399-e8e5-5061-b5a5-451deb5f02fa@gmail.com>
 <20180425140108.GA2597@pd.tnic>
 <48944beb-4e29-05cc-857b-7698e3dbe89b@gmail.com>
 <20180425171557.GC2597@pd.tnic>
 <96b6f27f-5e82-53f0-627f-85c2f31a095b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <96b6f27f-5e82-53f0-627f-85c2f31a095b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org, mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com, Yazen Ghannam <yazen.ghannam@amd.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 25, 2018 at 12:27:59PM -0500, Alex G. wrote:
> SURPRISE!!!

What does that mean? You've had too much coffee?

> It's coming (eventually). I'm trying to avoid pushing more than one
> series per week.

You better. Flooding people with patchsets won't get you very far.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
