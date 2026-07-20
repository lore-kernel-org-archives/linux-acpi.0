Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509E3E169E;
	Mon, 20 Jul 2026 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544517; cv=fail; b=Lhs8xqLXyb7m5UNlTvxuZkEs+/1K2MDu6M62sW0EM+nTgWZWHkaQLlK08N+1LKOhvxUCfvhkYtlXOZe/LSQgHwlZY6/iCO1oKFGslNBDR/Ns8sNZOkByeCJX7o3xGXpVkcW6cR5Kjz6drbY0fHNK/3a6nZBp185+rric5VqmNS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544517; c=relaxed/simple;
	bh=QM53TexXBZTyxBzyo0fsf7JxJ/4UQqPpGMG5eWEgeWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LBGh1aBGowvZ6/cwu2x+qNNQFCSJ090S54tNcZFg09qnbKOo+XE9gHaoxsfA26Wl/bQ9YPR2xnqQOgmzojuVdU+uEgzBz1dTIrcLRbH9fem0Rp46nsMxohRZL6Qh+yDCx2Vzu05sPt6QCs8h1X8z3xDuVrU7VA7B1+Qdg3Vggr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EKvYN8Km; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EKvYN8Km"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w72+68cLMLE/AAtCHh/W5AndpnboW3FG2w9AJcFnK3efETHMKH7xUN61zqSLV9aaZCyBMyCBzKlcJS33ID+BkOeK2SGjc2R2Cr/87spLghoMZV+ODHSN08VXywNR0XbzgAfkCHJ5QIGE1PwVLF+ryjotTTGpscycS7shQqNYzfMqttIUfn/uKWOx439azvUujvYJv743cUuKfZWyaTH4fpDlSJzvwVY/Lb44iIjtCBqngPETSt2yl7UvOLce+Zphwebh9gtW+aKE1AKxLIKwaHKyMXbiXDFAWVQB1yY7GqUwnoOPI2WfZc6lV2gSUnHDWxvKLKuBMxfja1htyj32aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIGe7ONR5zuxME1yNjPyPS+/y578Wx/bV5rPqYbh4eY=;
 b=grrTwoy7ehHh9oSP7mM5lDKjnFI7s8coHRn6tsX/cwDSg/WAE6TLB4phCu+HZPyvZScdVuU/d6+kpmXZ75wQaOdt/q3ZMOJd28tBfamvtgel2y/Y+IQY+cBWUCykUPSYVaewfnP3DdTzaowIWX3n6K7LP3xA06h3dLbsD5Ho7/nMK33OX9I8yFfdFDyZLKjzH0K6j7qEBa4ghvBrd4L1V9GSHqexbSOj8ABsmPto66LC5vt20M7h2FcPK72AJLeCFEjYVevpKB4jgTppXsg4tc0r/pi9w8gdJnaIXs+otmXe0A1TCuzNKfhRHjuJYLduhKBK+pbt2XJMkv0uBq2m+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIGe7ONR5zuxME1yNjPyPS+/y578Wx/bV5rPqYbh4eY=;
 b=EKvYN8Kmb4qdUulupk8BqilD605uY7xevI3O7YjF0ga1xI+3+L+iD3KF9p9gpctBXhNplLJ0/bI+WqQzY5nWKvd5O6GqhAVlAX+13mrwZ6Kt1Y10k2nRRv5Fh+Paq4KDrcLRMpmQGtPV+CL5wZV8BetbsXeMJS5JLT0DnJMExYol99PUcR9ZymjEGd2zeV72a/J32KQP/9fM6KkTQV55PMchXVXwy0CZw6r5OItLdYaz5SQgmGH5dTqVN4qm+jVwAAipmUQLxNg/+xr9LFwM0KCRn6o0VCFOq5roLsyHuViANEaJuHV9HVS0qvBGll9xlX/60HdOr4m/Gi78aRZzig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6)
 by AM9PR04MB7505.eurprd04.prod.outlook.com (2603:10a6:20b:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:48:20 +0000
Received: from DU0PR04MB9418.eurprd04.prod.outlook.com
 ([fe80::130:1767:2462:db72]) by DU0PR04MB9418.eurprd04.prod.outlook.com
 ([fe80::130:1767:2462:db72%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 10:48:19 +0000
Date: Mon, 20 Jul 2026 18:46:50 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] device property: add test cases for
 fwnode_for_each_child_node()
Message-ID: <jsds7dkt5qjgmjf6jya3chbeuso2ts4zlly7kvfd7lys4pzj2z@wua7qjndbrwp>
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
 <20260611203537.1786399-4-andriy.shevchenko@linux.intel.com>
 <DK1RFV9AABBD.KP0VPMWKFYWM@kernel.org>
 <alyMt-ya5skHmhtx@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alyMt-ya5skHmhtx@ashevche-desk.local>
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To DU0PR04MB9418.eurprd04.prod.outlook.com
 (2603:10a6:10:359::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9418:EE_|AM9PR04MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 910289b2-ff85-41c0-df57-08dee64c6800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	kMiFk4Ot7jYlX9qxTG/soPII83fDRFlRjYbd0MlHswB/i3pwX8kmnDnnWaoJSidhC1NaMPcjHM1QTUc3UndKxlzE0tGsxSs/kqLvbfZK2XW6iVclWmL07u9Vn772PasOhZWT3vN3vWn6HFyD4W32A74jgoCEnIngrpngOEtqOhtnrXs7oTNxNzkXBHEkjWiC45SSqRj2KaxeR8WPpSw2jc68KhY+XnNpLC9BDNoDJQSnrimzFaQlYWB8Lh6BAE4TdANyn89OX9WAZud8VMtwoupP5v5m0tov/ESx8o6vjZe5/YjhMmjgRab2PWxSAlHZJm+lJfeoSHG2R23Wk1mjnWPNlN4e0ta+9RzUu75SlcfSVIVB302Y65fx0Tw9rjoejYd082czyQUiPQsRzfhLQ3eKDss3KIWwHp5FZXNBhsLNWOKkzQwXOtI0ww9B27ID3YMhECS7HveXYIxZsJbXOfVo0NXoz6ZExBq1XfxUfwyeMa1esgZiUfy/H5WcXrhJlSHt4dgcqW5VgDdhlshFjdHsS6XpL6BZ1fhmi3rPclh/6v02zpePdsXpSkkCGmfRhqw5oTJp1QWCjmr+XYuXAe6xegTOZx5iYd5ewAoHdCXA1Q9wCPMqd7AefMIh12HKyHDp9tMaF/Uq4JgnxxwM4Q1a5yl0doS5a5uLXcA2W3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VuYFH7F/wIUiWocwrtLSjlkfzLdzFRodA/NOf3DJZXcQW9F4guamUrlJO1qN?=
 =?us-ascii?Q?u54ejrL9IFhOlZgCDVbJALZzc4y0mSbEniYPf8T5Koe6xIoejcEKG3U0tsVj?=
 =?us-ascii?Q?HPaDnb+mtOJOWToXIZLKLxAYS/JZ6TpT7anIiyv88rtmyUEw+kqsm7pGarOY?=
 =?us-ascii?Q?oe/CmkKFBg0N2IewcXIEAQNuu+vZuwue3PP8y7GHir4hdiUg66grut6u0Dp9?=
 =?us-ascii?Q?HoFdlpU+g2Y8JfIyrz+UBg7m2a6DmigGcara+EsvnDFEVWy0DE/zQOuoXowT?=
 =?us-ascii?Q?QZBRn0hU+f4UbV1XTEobSJuDJYpnAPT8/rNpurbixw7Les3HOgrKErwSI+9O?=
 =?us-ascii?Q?1GGKADLXidiiJumrVYr4fBJXXE/MC2ZX3kSZt7grBEy3zYQCzg5Bf8qCZnTB?=
 =?us-ascii?Q?BH1Tr+vFO6OsYeey+pFA0NM5mt79bgaES+jwn800IZVQEHGbycbVUBoNsRnE?=
 =?us-ascii?Q?GmHt3ZPgvgH2vY4vlDhZwAdkpTn4sWea7fINatkeliHJ4ckF87XxMncBx5/h?=
 =?us-ascii?Q?sctKyWldTkFOQviDYaIo6BFAmRwMeZrI01sFI0Br5dyXwzm0iML48jvd7AP3?=
 =?us-ascii?Q?U8Ypi2sf+5GUAKknkAm2Z1nA31uwgKvULd6ykI1IqQJXjl/xwPQI0+XmjWZS?=
 =?us-ascii?Q?tzFgbtbC3kOuB2iAXB+q/MUZ87ycjxFtC9xm9+WdIT7nFXmoLU8zi0UP89D1?=
 =?us-ascii?Q?yz5xsfUYzIllB9a3+JubL3ddIfBER6Y3EoDQUbYfJrT1kMJfLL23FKtpFPid?=
 =?us-ascii?Q?lVciiwVF0DhfXf4roKIZdISTGxl+tqVa5/PpMYgwWPQaje+/QV59GYvsnfUt?=
 =?us-ascii?Q?psQDmktrGAVGB0ymJIB3o3lFRFP34YmOJMPZgmzNGVux2MZ1RhejLHokFark?=
 =?us-ascii?Q?jL4kar2FnsY1ut/oK5U2sq1ctFFRoFDw6VcULCnp+l2DXqmc33g4H620oYsG?=
 =?us-ascii?Q?/zqmN70zJEJI+d7LeDc21GtKHt8riq2bxhWYdwW0U27cUupqj68li2OSq4ob?=
 =?us-ascii?Q?IMph9kidpnHhNrncvF+AMWbdMOlEcT0BBPyFHdvrhE4/nrqAWdT/+TH33WQN?=
 =?us-ascii?Q?0yT9CclezCvonzxraRoSYSd7r3o0H3mAsDZNlWTorwYMARDuq5jUw8k6un5J?=
 =?us-ascii?Q?AZot5lmLw/BH+2LQCWzHez1U5iIF5n9mTUX6I4Wgkmr9fpmsIRzu4IKznRK6?=
 =?us-ascii?Q?oiToP4SMdxKpcer+TkrToDDAukj9+c7SaG2SWhLJt/kJZ4jOgR8XF+Wn9IZy?=
 =?us-ascii?Q?ptxUbHqZq3AVRJe2LssulZQYdesZZZQKol9nj6KIKRIpcJHVH2HCaXDw3rvM?=
 =?us-ascii?Q?wOSHugfEfrRzfpBymxFqiNsatekzctM4Xo8Y4ZKYzbHP+oIfxHcwG13XGGYE?=
 =?us-ascii?Q?kcaoETQgMBzjF4742m4RFIYnnWbu5YvGW636nM5HEPqUbUZyf09L5OfOnaUf?=
 =?us-ascii?Q?QoooJwo+fcgtyei2zrtnhNwMxKlTBsCqSdhSIcfoxV0Dw7AOOxfbHRC1bmAA?=
 =?us-ascii?Q?UPkDfuNI5ZIIIpZDWnolo1mEHEjVmPlt5yByX+Ska8c3rPkfXmI8QQhSvhuk?=
 =?us-ascii?Q?DvpFy9s0yvg4fpNw+tx8d+XKWU2eTKKaQj+jSwtYDnlHv8jxg/ZjShasiX/s?=
 =?us-ascii?Q?l6bPkrvjp+CQQeDsro5u40GYZS9+BUh2wl8SFy9BqWFElIZ2Tq4JZMak+FU1?=
 =?us-ascii?Q?QNh6JhsM1SIa8/E19rlo/9NeRkWW0LV5pJiiBO7cvmm1FFrihTOZvWu6Vslp?=
 =?us-ascii?Q?+FBDb4RIEd+svKGlnxLsJJDt9HY8SWo2ZTXoPrIZSYCXcj8dL+of?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910289b2-ff85-41c0-df57-08dee64c6800
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:48:19.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWQbCeV+eRbq7WJfw4FgJYAJ59T6ZwbYNgDvfSO9o6bG/VnKJs7UoCsfCyW0LKlkMbPg0y2EDtTIhhGgGlSiJfO8HufJncZAhU3+isrrKXjjgfpm8qXgccYihTKw3Hue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7505

Hi Danilo and Andy,

On Sun, Jul 19, 2026 at 11:37:49AM +0300, Andy Shevchenko wrote:
> On Sat, Jul 18, 2026 at 04:18:12PM +0200, Danilo Krummrich wrote:
> > On Thu Jun 11, 2026 at 10:31 PM CEST, Andy Shevchenko wrote:
> > >
> > > Add test cases for fwnode_for_each_child_node() API.
> > >
> > > Test command:
> > > $ ./tools/testing/kunit/kunit.py run property-entry
> > >
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > This patch broke the build [1], hence I dropped it from the queue (but kept the
> > first two patches of this series).
> > 
> > of_node_init() can't be used from modules, either it needs EXPORT_SYMBOL_GPL()
> > itself, or of_node_ktype needs to be exported for this kunit test to work.
> 
> Oh, thanks for pointing out.

Fix patches are sent:
https://lore.kernel.org/imx/20260720104730.1285552-1-xu.yang_2@oss.nxp.com/

Thanks,
Xu Yang
